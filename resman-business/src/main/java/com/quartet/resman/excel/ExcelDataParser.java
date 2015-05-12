package com.quartet.resman.excel;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by lcheng on 2015/5/12.
 * Excel数据解析器
 */
public abstract class ExcelDataParser<T> {

    protected boolean hasSheetHeader = true;

    public List<T> parseData(File file) {
        List<T> result = new ArrayList();

        try (InputStream is = new FileInputStream(file)) {
            Workbook wb = WorkbookFactory.create(is);
            int numSheet = wb.getNumberOfSheets();
            for (int i = 0; i < numSheet; i++) {
                Sheet sheet = wb.getSheetAt(i);
                List<T> data = parseDataFromSheet(sheet);
                result.addAll(data);
            }
        } catch (IOException | InvalidFormatException e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<T> parseData(InputStream is){
        List<T> result = new ArrayList();
        try{
            Workbook wb = WorkbookFactory.create(is);
            int numSheet = wb.getNumberOfSheets();
            for (int i = 0; i < numSheet; i++) {
                Sheet sheet = wb.getSheetAt(i);
                List<T> data = parseDataFromSheet(sheet);
                result.addAll(data);
            }
        }catch (IOException | InvalidFormatException e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<T> parseDataFromSheet(Sheet sheet) {
        int maxRow = sheet.getLastRowNum();
        int startRow = 0;
        if (hasSheetHeader) {
            startRow = 1;
        }
        List<T> result = new ArrayList<>();
        for (int i = startRow; i <= maxRow; i++) {
            T t = parseDataFromRow(sheet.getRow(i));
            if(t!=null){
                result.add(t);
            }
        }
        return result;
    }

    protected abstract T parseDataFromRow(Row row);
}
