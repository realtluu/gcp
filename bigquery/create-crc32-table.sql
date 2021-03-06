CREATE OR REPLACE FUNCTION
  test.crc32(data STRING)
  RETURNS INT64
  LANGUAGE js AS """
  var makeCRCTable = function(){
    var c;
    var crcTable = [];
    for(var n =0; n < 256; n++){
      c = n;
      for(var k =0; k < 8; k++){
        c = ((c&1) ? (0xEDB88320 ^ (c >>> 1)) : (c >>> 1));
      }
      crcTable[n] = c;
    }
    return crcTable;
  }
  var crc32 = function(str) {
    if (str === null) {
      return null;
    }
    var crcTable = makeCRCTable();
    var crc = 0 ^ (-1);
    for (var i = 0; i < str.length; i++ ) {
      crc = (crc >>> 8) ^ crcTable[(crc ^ str.charCodeAt(i)) & 0xFF];
    }
    return (crc ^ (-1)) >>> 0;
  };
  return crc32(data);
""";