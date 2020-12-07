alias rosetta="arch -x86_64"

function mkg() {
    mkdir -p $@ && cd ${@:$#}
}
