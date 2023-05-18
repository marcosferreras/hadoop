//MaxTemperatureReducer Reducer for maximum temperature example
import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class MyReducer
  extends Reducer<Text, IntWritable, Text, IntWritable> {

  @Override
  public void reduce(Text key, Iterable<IntWritable> values,
      Context context)
      throws IOException, InterruptedException {
    
    int minNO2Value = Integer.MAX_VALUE;
    for (IntWritable value : values) {
      minNO2Value = Math.min(minNO2Value, value.get());
    }
    context.write(key, new IntWritable(minNO2Value));
  }
}

