package org.zerobase.service;

public class ManageString {

    public String manageApostrophe (String val) {
        if (!val.contains("'")) {
            return val;
        }
        StringBuilder stringBuilder = new StringBuilder();
        for (int i = 0 ; i < val.length() ; i++) {
            if (val.charAt(i) == '\'') {
                stringBuilder.append('\'');
                stringBuilder.append('\'');
            } else {
                stringBuilder.append(val.charAt(i));
            }
        }

        return stringBuilder.toString();
    }
}
