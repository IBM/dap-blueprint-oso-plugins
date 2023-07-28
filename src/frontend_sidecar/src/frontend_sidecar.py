# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

import os, logging, sys
from filters import JsonFilter
import consts
from dbaas_client import DBaaSClient

logging.basicConfig(stream=sys.stdout, level=logging.INFO)
logger = logging.getLogger(__name__)
logger.addFilter(JsonFilter(['password', 'client_secret']))

def bulk_download(to_dir=consts.PREPARED_DIR):
    os.makedirs(to_dir, exist_ok=True)
    dbaas_client = DBaaSClient()
    dbaas_client.dequeue_to_dir(to_dir)
    return to_dir
    
def bulk_upload(from_dir=consts.SIGNED_DIR):
    dbaas_client = DBaaSClient()
    for filename in os.listdir(from_dir):
        filepath = os.path.join(from_dir, filename)
        dbaas_client.enqueue_file(filepath)
        os.remove(filepath)

def backend_status():
    return 'OK', 200
