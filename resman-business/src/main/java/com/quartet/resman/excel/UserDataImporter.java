package com.quartet.resman.excel;

import com.quartet.resman.entity.User;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import java.io.*;
import java.util.List;

/**
 * Created by lcheng on 2015/5/11.
 */
public class UserDataImporter {

    public void importData(File file,String userType){
        try (InputStream is = new FileInputStream(file)) {
            Workbook wb = WorkbookFactory.create(is);
            int sheets = wb.getNumberOfSheets();
            for (int i=0;i<sheets;i++){

            }

        } catch (IOException|InvalidFormatException e) {
            e.printStackTrace();
        }
    }

    private List<User> parseUserFromSheet(Sheet sheet,String userType){
        int maxRow = sheet.getLastRowNum();
        if (maxRow>0){
            for(int i=0;i<maxRow;i++){
                User user = parseFromRow(sheet.getRow(i),userType);
            }
        }

        return null;
    }

    private User parseFromRow(Row row,String userType){
        //TODO
        return null;
    }
}
