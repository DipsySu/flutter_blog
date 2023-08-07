library test_package;

class Snowflake {
  // 开始时间截 (2020-04-01)
  static const int twepoch = 1585644268888;

  // 机器id所占的位数
  static const int workerIdBits = 5;
  // 数据标识id所占的位数
  static const int datacenterIdBits = 5;
  // 支持的最大机器id，结果是31
  static const int maxWorkerId = -1 ^ (-1 << workerIdBits);
  // 支持的最大数据标识id，结果是31
  static const int maxDatacenterId = -1 ^ (-1 << datacenterIdBits);
  // 序列在id中占的位数
  static const int sequenceBits = 12;

  // 机器ID向左移12位
  static const int workerIdShift = sequenceBits;
  // 数据标识id向左移17位
  static const int datacenterIdShift = sequenceBits + workerIdBits;
  // 时间截向左移22位
  static const int timestampLeftShift = sequenceBits + workerIdBits + datacenterIdBits;
  // 生成序列的掩码，这里为4095
  static const int sequenceMask = -1 ^ (-1 << sequenceBits);

  // 工作机器ID(0~31)
  final int workerId;
  // 数据中心ID(0~31)
  final int datacenterId;
  // 毫秒内序列(0~4095)
  int _sequence = 0;
  // 上次生成ID的时间截
  int _lastTimestamp = -1;

  Snowflake(this.workerId, this.datacenterId) {
    if (workerId > maxWorkerId || workerId < 0) {
      throw Exception('workerId can\'t be greater than $maxWorkerId or smaller than 0');
    }
    if (datacenterId > maxDatacenterId || datacenterId < 0) {
      throw Exception('datacenterId can\'t be greater than $maxDatacenterId or smaller than 0');
    }
  }

  // 获得下一个毫秒的时间戳
  int _tilNextMillis(int lastTimestamp) {
    int timestamp = _timeGen();
    while (timestamp <= lastTimestamp) {
      timestamp = _timeGen();
    }
    return timestamp;
  }

  // 返回以毫秒为单位的当前时间
  int _timeGen() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  // 生成下一个ID
  int nextId() {
    int timestamp = _timeGen();

    if (timestamp < _lastTimestamp) {
      throw Exception('Clock moved backwards. Refusing to generate id for ${_lastTimestamp - timestamp} milliseconds');
    }

    if (_lastTimestamp == timestamp) {
      _sequence = (_sequence + 1) & sequenceMask;
      if (_sequence == 0) {
        // 当前毫秒内序列溢出
        timestamp = _tilNextMillis(_lastTimestamp);
      }
    } else {
      _sequence = 0;
    }
    _lastTimestamp = timestamp;

    // 移位并通过或运算拼到一起组成64位的ID
    return ((timestamp - twepoch) << timestampLeftShift) | (datacenterId << datacenterIdShift) | (workerId << workerIdShift) | _sequence;
  }
}
