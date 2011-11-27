fix_nvm_npm_path() {
	VERSION=$1
	nvm use $VERSION
    if [[ $NODE_PATH == *$NVM_DIR/*/lib/node_modules* ]]; then
        NODE_PATH=${NODE_PATH%$NVM_DIR/*/lib/node_modules*}$NVM_DIR/$VERSION/lib/node_modules${PATH#*$NVM_DIR/*/lib/node_modules}
    else
        NODE_PATH="$NVM_DIR/$VERSION/lib/node_modules:$NODE_PATH"
    fi
}
