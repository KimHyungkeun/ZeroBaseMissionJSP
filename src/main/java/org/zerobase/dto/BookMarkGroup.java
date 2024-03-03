package org.zerobase.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class BookMarkGroup {
    private Integer id;
    private String bookmarkGroupName;
    private Integer orders;
    private Date registerDate;
    private Date updateDate;
}
