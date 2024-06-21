function print_open_tag(name, first_element) {
    if (!first_element) {
        printf(",\n");
    }
    printf("\"%s\": ", json_escape(name));
}

function print_value(val) {
    printf("\"%s\"", json_escape(val));
}

function json_escape(str) {
    gsub(/\\/, "\\\\", str);
    gsub(/"/, "\\\"", str);
    return str;
}

BEGIN {
    printf("{\n");
    first_element = 1;
}

{
    gsub(/<[^>]+>/, "");
    gsub(/[ \t]+/, "");
    if ($0 != "") {
        if (!first_element) {
            printf(",\n");
        }
        printf("\"data\": ");
        print_value($0);
        first_element = 0;
    }
}

END {
    printf("\n}\n");
}
