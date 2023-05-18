// MaxTemperatureMapper A Mapper that uses a utility class to parse records

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class MyMapper
    extends Mapper<LongWritable, Text, Text, IntWritable> {

  private MyParser parser = new MyParser();

  @Override
  public void map(LongWritable key, Text value, Context context)
      throws IOException, InterruptedException {

    parser.parse(value);
    if (parser.isValidNO2()) {
      context.write(new Text(parser.getYear()),
          new IntWritable(parser.getNO2()));
    }
  }
}

