# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

import pytest
from src.flask_util.app import create_app
from src.flask_util.config import SignedConfig
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
@pytest.fixture
def app(tmpdir, mocker):
    mocker.patch("src.dbaas_client.dap_resource.DAPDBaaSResource")
    mocker.patch("src.dbaas_client.dap_resource.dbaas.dequeue_all", return_value=sample_json) 
    mocker.patch("src.dbaas_client.dbaas.enqueue")
    config = SignedConfig()
    config.TESTING = True
    config.PREPARED_DIR = os.path.join(tmpdir, "/frontend-sidecar/prepared")
    config.SIGNED_DIR = os.path.join(tmpdir, "/frontend-sidecar/signed") 
  
    app = create_app(config=config)
    with app.app_context():
      yield app

@pytest.fixture
def client(app):
    """A test client for the app."""
    return app.test_client()