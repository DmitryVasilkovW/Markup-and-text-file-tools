function print_open_tag(name) {
    printf("\"%s\": {", name);
}

function print_value(val) {
    printf("\"%s\"", val);
}

function print_close_tag(name) {
    printf("}");
}

function print_full_tag(keystr, valuestr) {
    print_open_tag(keystr);
    print_value(valuestr);
    print_close_tag(keystr);
}

function print_array_start(name) {
    printf("\"%s\": [", name);
}

function print_array_end() {
    printf("]");
}

function print_array_element(value) {
    printf("\"%s\"", value);
}

function parse(input_str, key, value, groups) {
    while(match(input_str, /<(\w+)>([^<]+)<\/\1>/, groups) != 0) {
        input_str = substr(input_str, RSTART + RLENGTH);

        key = groups[1];
        value = groups[2];
        parse_value(value, key);
    }
}

function parse_value(value, key) {
    if(match(value, /<[^>]+>/) != 0) {
        print_open_tag(key);
        parse(value, "", "", "");
        print_close_tag(key);
    }
    else {
        print_full_tag(key, value);
    }
}

BEGIN {
    input_file = "input.xml";
    output_file = "output.json";
}

{
    input = input $0;
}

END {
    gsub(/[ \n\t]+/, "", input);
    parse(input, "", "", "");
    print "";
}
