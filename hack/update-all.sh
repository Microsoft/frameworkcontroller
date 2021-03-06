#!/bin/bash

# MIT License
#
# Copyright (c) Microsoft Corporation. All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE

set -o errexit
set -o nounset
set -o pipefail

BASH_DIR=$(cd $(dirname ${BASH_SOURCE}) && pwd)
PROJECT_DIR=${BASH_DIR}/..
CODEGEN_DIR=${PROJECT_DIR}/pkg/client
CODEGEN_FILE=${PROJECT_DIR}/pkg/apis/frameworkcontroller/v1/zz_generated.deepcopy.go
GOPKG_LOCK_FILE=${PROJECT_DIR}/Gopkg.lock

cd ${PROJECT_DIR}

# Remove possible stale import in generated code
rm -rf ${CODEGEN_DIR} ${CODEGEN_FILE} ${GOPKG_LOCK_FILE}

# Update dependent package for non-generated code, such as the code-generator itself
${BASH_DIR}/update-dep.sh

# Generate code
${BASH_DIR}/update-codegen.sh

# Update dependent package for generated code
${BASH_DIR}/update-dep.sh

echo Succeeded to update all
