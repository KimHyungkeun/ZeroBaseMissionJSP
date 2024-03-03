package org.zerobase.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class BookMarkList {
    private Integer id;
    private Integer bookmarkGroupId;
    private String bookmarkGroupName;
    private String wifiManagerNo;
    private String wifiName;
    private Date registerDate;

}
