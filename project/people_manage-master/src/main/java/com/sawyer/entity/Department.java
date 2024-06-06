package com.sawyer.entity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;


@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Department {
    private int dep_ID;
    private String dep_phone;
    private String dep_name;
    private String creat_date;

}
