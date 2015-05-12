package com.quartet.resman.excel;

import com.quartet.resman.entity.User;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;

import java.text.DecimalFormat;
import java.util.Date;

/**
 * Created by lcheng on 2015/5/12.
 */
public class UserDataParser extends ExcelDataParser<User> {

    private String userType;

    public UserDataParser(String userType) {
        this.userType = userType;
    }

    @Override
    protected User parseDataFromRow(Row row) {
        if (userType.equalsIgnoreCase("student")) {
            return parseStudent(row);
        } else if (userType.equalsIgnoreCase("teacher")) {
            return parseTeacher(row);
        }
        return null;
    }

    private User parseStudent(Row row) {
        int maxCell = row.getLastCellNum();
        if (maxCell < 6) {
            return null;
        }
        Cell cell = row.getCell(0);
        String className = (cell != null) ? cell.getStringCellValue() : null;

        cell = row.getCell(1);
        String major = (cell != null) ? cell.getStringCellValue() : "";

        cell = row.getCell(2);
        String studentNo = (cell != null) ? cell.getStringCellValue() : null;

        cell = row.getCell(3);
        String name = (cell != null) ? cell.getStringCellValue() : null;

        cell = row.getCell(4);
        String sex = (cell != null) ? cell.getStringCellValue() : "";
        sex = sex.equals("男")|| sex.equals("male") ? "Male" : "Female";
        User.Sex sexVal = User.Sex.valueOf(sex);

        cell = row.getCell(5);
        Date bod = parseCellValue(cell,Date.class);

        if (className!=null && studentNo!=null && name!=null){
            User user = new User();
            user.setClassName(className);
            user.setMajor(major);
            user.setStudentNo(studentNo);
            user.setSex(sexVal);
            user.setName(name);
            user.setBod(bod);
            user.setUserType(User.Type.valueOf(userType));
            return user;
        }
        return null;
    }

    private User parseTeacher(Row row) {
        Cell cell = row.getCell(0);
        String name = (cell != null) ? cell.getStringCellValue() : null;

        cell = row.getCell(1);
        String sex = (cell != null) ? cell.getStringCellValue() : "";
        sex = sex.equals("男")|| sex.equals("male") ? "Male" : "Female";
        User.Sex sexVal = User.Sex.valueOf(sex);

        cell = row.getCell(2);
        String empNo = (cell != null) ? cell.getStringCellValue() : null;

        cell = row.getCell(3);
        String title = (cell != null) ? cell.getStringCellValue() : null;

        cell = row.getCell(4);
        Date bod = parseCellValue(cell,Date.class);

        if (name!=null){
            User user = new User();
            user.setSex(sexVal);
            user.setName(name);
            user.setBod(bod);
            user.setTitle(title);
            user.setEmpNo(empNo);
            user.setUserType(User.Type.valueOf(userType));
            return user;
        }
        return null;
    }

    private <V> V parseCellValue(Cell cell, Class<V> clazz) {
        if (cell != null) {
            switch (cell.getCellType()) {
                case HSSFCell.CELL_TYPE_STRING:
                    return clazz.cast(cell.getStringCellValue());
                case HSSFCell.CELL_TYPE_NUMERIC:
                    if (HSSFDateUtil.isCellDateFormatted(cell)) {
                        short format = cell.getCellStyle().getDataFormat();
                        if (format == 14 || format == 31 || format == 57 || format == 58 || format == 20 || format == 32) {
                            double value = cell.getNumericCellValue();
                            Date date = DateUtil.getJavaDate(value);
                            return clazz.cast(date);
                        } else {
                            Double value = cell.getNumericCellValue();
                            return clazz.cast(value);
                        }
                    }
            }
        }
        return null;
    }
}
