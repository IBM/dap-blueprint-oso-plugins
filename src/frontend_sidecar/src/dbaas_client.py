# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

import json, os, uuid

import dap_consts
import dap_resource
import dbaas

class DBaaSClient:

    def __init__(self):
        self.query = {'$or': [{'request.type': {'$eq': x}} for x in dap_consts.REQUEST_TYPES + [dap_consts.INTERNAL_OPERATION]],
                      dap_consts.SIGNING_SERVICE: {'$eq': None}}
        for serviceid in dap_consts.POLICY_SERVICES:
            self.query[serviceid] = {'$ne': None}
        print('query={}'.format(self.query))
        self.resource = dap_resource.DAPDBaaSResource(serviceid=serviceid)

    def dequeue_to_dir(self, save_dir):
        docs = dbaas.dequeue_all(self.resource.txqueue_client, self.resource.queue_name, self.query)
        print('Dequeued {} docs'.format(len(docs)))
        for i, doc in enumerate(docs):
            file_name = os.path.join(save_dir, str(uuid.uuid4()))
            print('Saving a document into {}'.format(file_name))
            json.dumps(doc, indent=4)
            with open(file_name, 'w') as f:
                json.dump(doc, f, indent=4)
            print()

    def enqueue_file(self, file_name):
        with open(file_name) as f:
            doc = json.load(f)
            dbaas.enqueue(self.resource.txqueue_client, self.resource.queue_name, doc)
            print('enqueued {}'.format(file_name))
