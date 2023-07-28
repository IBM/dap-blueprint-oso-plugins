# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

import requests
import unittest


def test_bulk_download(client, mocker, mock_session_get):
    mock_session_get.side_effect = [
        mocker.Mock(headers={'Content-Disposition': True}, content=b'test1'),
        mocker.Mock(headers={'Content-Disposition': True}, content=b'test2'),
        mocker.Mock(headers={}, content=None),
    ]
    mocker.patch("uuid.uuid4", side_effect=["file1", "file2"])

    response = client.get("api/backend/v1alpha1/documents").json

    assert response == {
        'documents': [
            {'id': 'file2', 'content': 'test2'},
            {'id': 'file1', 'content': 'test1'},
        ],
        'count': 2
    }


def test_bulk_upload(client, mocker, mock_session_post):
    res_obj = mocker.Mock("requests.Response")

    mock_session_post.return_value = res_obj

    documents = [
        { "id": "file3", "content": "test"},
        { "id": "file4", "content": "test"},
    ]

    data = {
        "documents":  documents,
        "count": len(documents)
    }
    response = client.post('api/backend/v1alpha1/documents', json=data).json

    assert response == 'OK'


def test_status(client, mocker, mock_session_get):
    res_obj=mocker.Mock('requests.Response')
    mock_session_get.return_value = res_obj

    response = client.get('api/backend/v1alpha1/status')
    assert response.status_code == 200
    assert response.json == {'status': 'OK'}
    
def test_status_timeout(client, mocker, mock_session_get):
    mock_session_get.side_effect = requests.exceptions.HTTPError

    response = client.get('api/backend/v1alpha1/status')
    assert response.status_code == 503
