# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

import os
import consts

import rest_client

def save_documents(documents, to_dir=consts.PREPARED_DIR):
    os.makedirs(to_dir, exist_ok=True)
    for document in documents:
        filepath = os.path.join(to_dir, document['id'])
        with open(filepath, 'w') as f:
            f.write(document["content"])

def bulk_upload(from_dir=consts.PREPARED_DIR):
    for filename in os.listdir(from_dir):
        filepath = os.path.join(from_dir, filename)
        rest_client.upload_prepared_doc(filepath)
        os.remove(filepath)

def bulk_download(to_dir=consts.SIGNED_DIR):
    documents = []
    while True:
        filepath = rest_client.download_signed_file(to_dir)
        if filepath == None:
            break

    for filename in os.listdir(to_dir):
        filepath = os.path.join(to_dir, filename)
        with open(filepath, 'r') as f:
            documents.append({ 'id': filename, 'content': f.read() })
        os.remove(filepath)
    return documents

def backend_status():
    return rest_client.status()

