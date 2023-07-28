# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

import json
from src import consts
import os
sample_json = [
  {
    "id": "filename1",
    "content": "content1",
  },
  {
    "id": "filename2",
    "content": "content2",
  }
]
def test_download(client):
    response = client.get("/api/frontend/v1alpha1/documents").json
    print("Response of download", response)
    assert response['count'] == 2    

def test_upload(client, mocker):
  mocker.patch("src.frontend_sidecar.os.listdir")
  response = client.post("api/frontend/v1alpha1/documents", data =
   json.dumps({'documents' : [
        {
            "id": "filename",
            "content": "file content",
        },
        {
            "id": "filename",
            "content": "file content",
        }
        ]})).json
  print("Response of upload", response)
  count_of_files=0
  for filename in os.listdir(consts.SIGNED_DIR):
      count_of_files+=1
  assert count_of_files == 0
  assert response == "OK"

def test_backend_status(client):
    response = client.get("/api/frontend/v1alpha1/status").json
    print('Reponse of backend_status', response)
    assert response['status'] == 'OK'
