#!/bin/bash
aws s3 sync ./s3/web/static s3://www.dokuryo.info/static
aws s3 sync ./s3/web/mypage s3://www.dokuryo.info/mypage
aws s3 sync ./s3/web/packages/browser s3://www.dokuryo.info/packages/browser
