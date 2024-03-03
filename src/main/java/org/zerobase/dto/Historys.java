package org.zerobase.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Historys {
    private Integer id;
    private Double xPos;
    private Double yPos;
    private Date checkDate;
}
