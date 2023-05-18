//NcdcRecordParser A class for parsing weather records in NCDC format
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.apache.hadoop.io.Text;

public class MyParser {
  
  private static final String MISSING_DATA = "";
  
  LocalDate date;
  DateTimeFormatter formatter;
  String no2String;
  
  private String year;
  
  public void parse(String record) {
	String[] values = record.split(";");
	  
	formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
	date = LocalDate.parse(values[0], formatter);
	  
    year = Integer.toString(date.getYear());
    
    no2String = values[3];

  }
  
  public void parse(Text record) {
    parse(record.toString());
  }

  public boolean isValidNO2() {
    return !no2String.equals(MISSING_DATA);
  }
  
  public String getYear() {
    return year;
  }

  public int getNO2() {
	  //There are integer values represented as xxx.0, so we use Math.round() in order to avoid errors
	  return Math.round(Float.parseFloat(no2String));
  }
}

