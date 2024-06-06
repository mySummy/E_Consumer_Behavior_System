package com.sawyer.dao;

import com.sawyer.entity.Department;
import com.sawyer.entity.Emp;

import java.util.List;
public interface DepartmentDAO {
    List<Emp> findAll();

    void save(Department dep);

    void delete(int id);

    Department find(int id);

    void update(Department dep);
}
