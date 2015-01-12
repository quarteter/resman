package com.quartet.resman.utils;

/**
 * Created by lcheng on 2015/1/10.
 */
public class Types {

    public static enum Folders {
        Generic("g"),Course("c"), ClassicCourse("cc"), Homework("h");

        private String value;

        Folders(String value) {
            this.value = value;
        }

        public String getValue() {
            return value;
        }

    }

    public static enum Status {
        UnReviewed("0"), Reviewed("1");

        private String value;

        Status(String value) {
            this.value = value;
        }

        public String getValue() {
            return value;
        }
    }

    public static enum Visibility {
        All("a"), Teacher("t"), Student("s");

        private String value;

        Visibility(String value) {
            this.value = value;
        }

        public String getValue() {
            return value;
        }
    }
}
