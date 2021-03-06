lexer grammar USqlLexer;

CREATE
	: 'CREATE'
	;

ALTER
	: 'ALTER'
	;

DATABASE
	: 'DATABASE'
	;

SCHEMA
	: 'SCHEMA'
	;

TABLE
	: 'TABLE'
	;

COLUMN
	: 'COLUMN'
	;

REBUILD
	: 'REBUILD'
	;

INDEX
	: 'INDEX'
	;

CLUSTERED
	: 'CLUSTERED'
	;

DECLARE
	: 'DECLARE'
	;

IF
	: 'IF'
	;

NOT
	: 'NOT'
	;

EXISTS
	: 'EXISTS'
	;

ADD
	: 'ADD'
	;

DROP
	: 'DROP'
	;

USE
	: 'USE'
	;

INSERT
	: 'INSERT'
	;

INTO
	: 'INTO'
	;

VALUES
	: 'VALUES'
	;

ASC
	: 'ASC'
	;

DESC
	: 'DESC'
	;

RANGE
	: 'RANGE'
	;

HASH
	: 'HASH'
	;

DIRECT
	: 'DIRECT'
	;

ROUND
	: 'ROUND'
	;

ROBIN
	: 'ROBIN'
	;

DISTRIBUTED
	: 'DISTRIBUTED'
	;

PARTITIONED
	: 'PARTITIONED'
	;

PARTITION
	: 'PARTITION'
	;

BY
	: 'BY'
	;

ON
	: 'ON'
	;

IGNORE
	: 'IGNORE'
	;

MOVE
	: 'MOVE'
	;

TO
	: 'TO'
	;

INTEGRITY
	: 'INTEGRITY'
	;

VIOLATION
	: 'VIOLATION'
	;

NEW
	: 'new'
	;

fragment DateTime
	: 'DateTime'
	;

/*
 * Literals
 */
fragment DecimalDigit
	: '0' .. '9'
	;

fragment HexDigit
	: DecimalDigit
	| 'a' .. 'f'
	| 'A' .. 'F'
	;

fragment IntegerTypeSuffix
	:  'U' | 'u' | 'L' | 'l' | 'UL' | 'uL' | 'Ul' | 'ul' | 'LU' | 'Lu' | 'lU' | 'lu'
	;

fragment Sign
	: '+' | '-'
	;

fragment ExponentPart
	: 'e' ( Sign )? DecimalDigits
	| 'E' ( Sign )? DecimalDigits
	;

fragment RealTypeSuffix
	: 'F' | 'f' | 'D' | 'd' | 'M' | 'm'
	;

fragment SingleCharacter
	: ~( '\u0027' | '\'' | '\\' | '\u005c' | '\n' )
	;

fragment SimpleEscapeSequence
	: '\\\''
	| '\\"'
	| '\\\\'
	| '\\0'
	| '\\a'
	| '\\b'
	| '\\f'
	| '\\n'
	| '\\r'
	| '\\t'
	| '\\v'
	;

fragment HexadecimalEscapeSequence
	: '\\x' HexDigit ( HexDigit )? ( HexDigit )? ( HexDigit )?
	;

fragment UnicodeEscapeSequence
	: '\\u' HexDigit HexDigit HexDigit HexDigit
	| '\\u' HexDigit HexDigit HexDigit HexDigit HexDigit HexDigit HexDigit HexDigit
	;

fragment Character
	: SingleCharacter
	| SimpleEscapeSequence
	| HexadecimalEscapeSequence
	| UnicodeEscapeSequence
	;

fragment SingleRegularStringLiteralCharacter
	: ~( '\u0022' | '"' | '\\' | '\u005c' | '\n' )
	;

fragment RegularStringLiteralCharacter
	: SingleRegularStringLiteralCharacter
	| SimpleEscapeSequence
	| HexadecimalEscapeSequence
	| UnicodeEscapeSequence
	;

NullLiteral
	: 'null'
	;

BooleanLiteral
	: 'true' | 'false'
	;

IntegerLiteral
	: DecimalIntegerLiteral
	| HexadecimalIntegerLiteral
	;

RealLiteral
	: DecimalDigits '.' DecimalDigits ( ExponentPart )? ( RealTypeSuffix )?
	| '.' DecimalDigits ( ExponentPart )? ( RealTypeSuffix )?
	| DecimalDigits ExponentPart ( RealTypeSuffix )?
	| DecimalDigits RealTypeSuffix
	;

HexDigits
	: HexDigit ( HexDigit )*
	;

HexadecimalIntegerLiteral
	: '0x' HexDigits ( IntegerTypeSuffix )?
	;

DecimalDigits
	: DecimalDigit ( DecimalDigit )*
	;

DecimalIntegerLiteral
	: DecimalDigits ( IntegerTypeSuffix )?
	;

CharLiteral
	: '\'' Character '\''
	;

StringLiteral
	: '"' ( RegularStringLiteralCharacter )* '"'
	;

NumericTypeNonNullable
	: 'byte' | 'sbyte' | 'int' | 'uint' | 'long' | 'ulong' | 'float' | 'double' | 'decimal' | 'short' | 'ushort' | 'System.Int32'
	;

TextualType
	: 'char' | 'char?' | 'string' | 'System.String'
	;

TemporalType
	: DateTime | DateTime '?' | 'System.' DateTime
	;

OtherType
	: 'bool' | 'bool?' | 'Guid' | 'Guid?' | 'byte[]' | 'System.Boolean'
	;

NEWLINE
   : '\r'? '\n' -> skip
   ;

WS
   : ( ' ' | '\t' | '\n' | '\r' )+ -> skip
   ;

fragment LetterCharacter
	: ( 'a' .. 'z' | 'A' .. 'Z' )
	;

fragment NumberCharacter 
	: ( '0' .. '9' )
	;

fragment UnderscoreCharacter
	: '_'
	;

EscapedQuote
	: '[[' | ']]'
	;

fragment ConnectingCharacter
	: ( UnderscoreCharacter | '\u203F' | '\u2040' | '\u2054' | '\uFE33' | '\uFE34' | '\uFE4D' | '\uFE4E' | '\uFE4F' | '\uFF3F' )
	;

fragment CombiningCharacter
	: ( '\u0300' | '\u0301' | '\u0302' | '\u0303' | '\u0304' | '\u0305' | '\u0306' | '\u0307' | '\u0308' | '\u0309' | '\u030A' | '\u030B' | '\u030C' | '\u030D' | '\u030E' | '\u030F' | '\u0310' | '\u0311' | '\u0312' | '\u0313' | '\u0314' | '\u0315' | '\u0316' | '\u0317' | '\u0318' | '\u0319' | '\u031A' | '\u031B' | '\u031C' | '\u031D' | '\u031E' | '\u031F' | '\u0320' | '\u0321' | '\u0322' | '\u0323' | '\u0324' | '\u0325' | '\u0326' | '\u0327' | '\u0328' | '\u0329' | '\u032A' | '\u032B' | '\u032C' | '\u032D' | '\u032E' | '\u032F' | '\u0330' | '\u0331' | '\u0332' | '\u0333' | '\u0334' | '\u0335' | '\u0336' | '\u0337' | '\u0338' | '\u0339' | '\u033A' | '\u033B' | '\u033C' | '\u033D' | '\u033E' | '\u033F' | '\u0340' | '\u0341' | '\u0342' | '\u0343' | '\u0344' | '\u0345' | '\u0346' | '\u0347' | '\u0348' | '\u0349' | '\u034A' | '\u034B' | '\u034C' | '\u034D' | '\u034E' | '\u034F' | '\u0350' | '\u0351' | '\u0352' | '\u0353' | '\u0354' | '\u0355' | '\u0356' | '\u0357' | '\u0358' | '\u0359' | '\u035A' | '\u035B' | '\u035C' | '\u035D' | '\u035E' | '\u035F' | '\u0360' | '\u0361' | '\u0362' | '\u0363' | '\u0364' | '\u0365' | '\u0366' | '\u0367' | '\u0368' | '\u0369' | '\u036A' | '\u036B' | '\u036C' | '\u036D' | '\u036E' | '\u036F' | '\u0483' | '\u0484' | '\u0485' | '\u0486' | '\u0487' | '\u0591' | '\u0592' | '\u0593' | '\u0594' | '\u0595' | '\u0596' | '\u0597' | '\u0598' | '\u0599' | '\u059A' | '\u059B' | '\u059C' | '\u059D' | '\u059E' | '\u059F' | '\u05A0' | '\u05A1' | '\u05A2' | '\u05A3' | '\u05A4' | '\u05A5' | '\u05A6' | '\u05A7' | '\u05A8' | '\u05A9' | '\u05AA' | '\u05AB' | '\u05AC' | '\u05AD' | '\u05AE' | '\u05AF' | '\u05B0' | '\u05B1' | '\u05B2' | '\u05B3' | '\u05B4' | '\u05B5' | '\u05B6' | '\u05B7' | '\u05B8' | '\u05B9' | '\u05BA' | '\u05BB' | '\u05BC' | '\u05BD' | '\u05BF' | '\u05C1' | '\u05C2' | '\u05C4' | '\u05C5' | '\u05C7' | '\u0610' | '\u0611' | '\u0612' | '\u0613' | '\u0614' | '\u0615' | '\u0616' | '\u0617' | '\u0618' | '\u0619' | '\u061A' | '\u064B' | '\u064C' | '\u064D' | '\u064E' | '\u064F' | '\u0650' | '\u0651' | '\u0652' | '\u0653' | '\u0654' | '\u0655' | '\u0656' | '\u0657' | '\u0658' | '\u0659' | '\u065A' | '\u065B' | '\u065C' | '\u065D' | '\u065E' | '\u065F' | '\u0670' | '\u06D6' | '\u06D7' | '\u06D8' | '\u06D9' | '\u06DA' | '\u06DB' | '\u06DC' | '\u06DF' | '\u06E0' | '\u06E1' | '\u06E2' | '\u06E3' | '\u06E4' | '\u06E7' | '\u06E8' | '\u06EA' | '\u06EB' | '\u06EC' | '\u06ED' | '\u0711' | '\u0730' | '\u0731' | '\u0732' | '\u0733' | '\u0734' | '\u0735' | '\u0736' | '\u0737' | '\u0738' | '\u0739' | '\u073A' | '\u073B' | '\u073C' | '\u073D' | '\u073E' | '\u073F' | '\u0740' | '\u0741' | '\u0742' | '\u0743' | '\u0744' | '\u0745' | '\u0746' | '\u0747' | '\u0748' | '\u0749' | '\u074A' | '\u07A6' | '\u07A7' | '\u07A8' | '\u07A9' | '\u07AA' | '\u07AB' | '\u07AC' | '\u07AD' | '\u07AE' | '\u07AF' | '\u07B0' | '\u07EB' | '\u07EC' | '\u07ED' | '\u07EE' | '\u07EF' | '\u07F0' | '\u07F1' | '\u07F2' | '\u07F3' | '\u0816' | '\u0817' | '\u0818' | '\u0819' | '\u081B' | '\u081C' | '\u081D' | '\u081E' | '\u081F' | '\u0820' | '\u0821' | '\u0822' | '\u0823' | '\u0825' | '\u0826' | '\u0827' | '\u0829' | '\u082A' | '\u082B' | '\u082C' | '\u082D' | '\u0859' | '\u085A' | '\u085B' | '\u08D4' | '\u08D5' | '\u08D6' | '\u08D7' | '\u08D8' | '\u08D9' | '\u08DA' | '\u08DB' | '\u08DC' | '\u08DD' | '\u08DE' | '\u08DF' | '\u08E0' | '\u08E1' | '\u08E3' | '\u08E4' | '\u08E5' | '\u08E6' | '\u08E7' | '\u08E8' | '\u08E9' | '\u08EA' | '\u08EB' | '\u08EC' | '\u08ED' | '\u08EE' | '\u08EF' | '\u08F0' | '\u08F1' | '\u08F2' | '\u08F3' | '\u08F4' | '\u08F5' | '\u08F6' | '\u08F7' | '\u08F8' | '\u08F9' | '\u08FA' | '\u08FB' | '\u08FC' | '\u08FD' | '\u08FE' | '\u08FF' | '\u0900' | '\u0901' | '\u0902' | '\u093A' | '\u093C' | '\u0941' | '\u0942' | '\u0943' | '\u0944' | '\u0945' | '\u0946' | '\u0947' | '\u0948' | '\u094D' | '\u0951' | '\u0952' | '\u0953' | '\u0954' | '\u0955' | '\u0956' | '\u0957' | '\u0962' | '\u0963' | '\u0981' | '\u09BC' | '\u09C1' | '\u09C2' | '\u09C3' | '\u09C4' | '\u09CD' | '\u09E2' | '\u09E3' | '\u0A01' | '\u0A02' | '\u0A3C' | '\u0A41' | '\u0A42' | '\u0A47' | '\u0A48' | '\u0A4B' | '\u0A4C' | '\u0A4D' | '\u0A51' | '\u0A70' | '\u0A71' | '\u0A75' | '\u0A81' | '\u0A82' | '\u0ABC' | '\u0AC1' | '\u0AC2' | '\u0AC3' | '\u0AC4' | '\u0AC5' | '\u0AC7' | '\u0AC8' | '\u0ACD' | '\u0AE2' | '\u0AE3' | '\u0AFA' | '\u0AFB' | '\u0AFC' | '\u0AFD' | '\u0AFE' | '\u0AFF' | '\u0B01' | '\u0B3C' | '\u0B3F' | '\u0B41' | '\u0B42' | '\u0B43' | '\u0B44' | '\u0B4D' | '\u0B56' | '\u0B62' | '\u0B63' | '\u0B82' | '\u0BC0' | '\u0BCD' | '\u0C00' | '\u0C3E' | '\u0C3F' | '\u0C40' | '\u0C46' | '\u0C47' | '\u0C48' | '\u0C4A' | '\u0C4B' | '\u0C4C' | '\u0C4D' | '\u0C55' | '\u0C56' | '\u0C62' | '\u0C63' | '\u0C81' | '\u0CBC' | '\u0CBF' | '\u0CC6' | '\u0CCC' | '\u0CCD' | '\u0CE2' | '\u0CE3' | '\u0D00' | '\u0D01' | '\u0D3B' | '\u0D3C' | '\u0D41' | '\u0D42' | '\u0D43' | '\u0D44' | '\u0D4D' | '\u0D62' | '\u0D63' | '\u0DCA' | '\u0DD2' | '\u0DD3' | '\u0DD4' | '\u0DD6' | '\u0E31' | '\u0E34' | '\u0E35' | '\u0E36' | '\u0E37' | '\u0E38' | '\u0E39' | '\u0E3A' | '\u0E47' | '\u0E48' | '\u0E49' | '\u0E4A' | '\u0E4B' | '\u0E4C' | '\u0E4D' | '\u0E4E' | '\u0EB1' | '\u0EB4' | '\u0EB5' | '\u0EB6' | '\u0EB7' | '\u0EB8' | '\u0EB9' | '\u0EBB' | '\u0EBC' | '\u0EC8' | '\u0EC9' | '\u0ECA' | '\u0ECB' | '\u0ECC' | '\u0ECD' | '\u0F18' | '\u0F19' | '\u0F35' | '\u0F37' | '\u0F39' | '\u0F71' | '\u0F72' | '\u0F73' | '\u0F74' | '\u0F75' | '\u0F76' | '\u0F77' | '\u0F78' | '\u0F79' | '\u0F7A' | '\u0F7B' | '\u0F7C' | '\u0F7D' | '\u0F7E' | '\u0F80' | '\u0F81' | '\u0F82' | '\u0F83' | '\u0F84' | '\u0F86' | '\u0F87' | '\u0F8D' | '\u0F8E' | '\u0F8F' | '\u0F90' | '\u0F91' | '\u0F92' | '\u0F93' | '\u0F94' | '\u0F95' | '\u0F96' | '\u0F97' | '\u0F99' | '\u0F9A' | '\u0F9B' | '\u0F9C' | '\u0F9D' | '\u0F9E' | '\u0F9F' | '\u0FA0' | '\u0FA1' | '\u0FA2' | '\u0FA3' | '\u0FA4' | '\u0FA5' | '\u0FA6' | '\u0FA7' | '\u0FA8' | '\u0FA9' | '\u0FAA' | '\u0FAB' | '\u0FAC' | '\u0FAD' | '\u0FAE' | '\u0FAF' | '\u0FB0' | '\u0FB1' | '\u0FB2' | '\u0FB3' | '\u0FB4' | '\u0FB5' | '\u0FB6' | '\u0FB7' | '\u0FB8' | '\u0FB9' | '\u0FBA' | '\u0FBB' | '\u0FBC' | '\u0FC6' | '\u102D' | '\u102E' | '\u102F' | '\u1030' | '\u1032' | '\u1033' | '\u1034' | '\u1035' | '\u1036' | '\u1037' | '\u1039' | '\u103A' | '\u103D' | '\u103E' | '\u1058' | '\u1059' | '\u105E' | '\u105F' | '\u1060' | '\u1071' | '\u1072' | '\u1073' | '\u1074' | '\u1082' | '\u1085' | '\u1086' | '\u108D' | '\u109D' | '\u135D' | '\u135E' | '\u135F' | '\u1712' | '\u1713' | '\u1714' | '\u1732' | '\u1733' | '\u1734' | '\u1752' | '\u1753' | '\u1772' | '\u1773' | '\u17B4' | '\u17B5' | '\u17B7' | '\u17B8' | '\u17B9' | '\u17BA' | '\u17BB' | '\u17BC' | '\u17BD' | '\u17C6' | '\u17C9' | '\u17CA' | '\u17CB' | '\u17CC' | '\u17CD' | '\u17CE' | '\u17CF' | '\u17D0' | '\u17D1' | '\u17D2' | '\u17D3' | '\u17DD' | '\u180B' | '\u180C' | '\u180D' | '\u1885' | '\u1886' | '\u18A9' | '\u1920' | '\u1921' | '\u1922' | '\u1927' | '\u1928' | '\u1932' | '\u1939' | '\u193A' | '\u193B' | '\u1A17' | '\u1A18' | '\u1A1B' | '\u1A56' | '\u1A58' | '\u1A59' | '\u1A5A' | '\u1A5B' | '\u1A5C' | '\u1A5D' | '\u1A5E' | '\u1A60' | '\u1A62' | '\u1A65' | '\u1A66' | '\u1A67' | '\u1A68' | '\u1A69' | '\u1A6A' | '\u1A6B' | '\u1A6C' | '\u1A73' | '\u1A74' | '\u1A75' | '\u1A76' | '\u1A77' | '\u1A78' | '\u1A79' | '\u1A7A' | '\u1A7B' | '\u1A7C' | '\u1A7F' | '\u1AB0' | '\u1AB1' | '\u1AB2' | '\u1AB3' | '\u1AB4' | '\u1AB5' | '\u1AB6' | '\u1AB7' | '\u1AB8' | '\u1AB9' | '\u1ABA' | '\u1ABB' | '\u1ABC' | '\u1ABD' | '\u1B00' | '\u1B01' | '\u1B02' | '\u1B03' | '\u1B34' | '\u1B36' | '\u1B37' | '\u1B38' | '\u1B39' | '\u1B3A' | '\u1B3C' | '\u1B42' | '\u1B6B' | '\u1B6C' | '\u1B6D' | '\u1B6E' | '\u1B6F' | '\u1B70' | '\u1B71' | '\u1B72' | '\u1B73' | '\u1B80' | '\u1B81' | '\u1BA2' | '\u1BA3' | '\u1BA4' | '\u1BA5' | '\u1BA8' | '\u1BA9' | '\u1BAB' | '\u1BAC' | '\u1BAD' | '\u1BE6' | '\u1BE8' | '\u1BE9' | '\u1BED' | '\u1BEF' | '\u1BF0' | '\u1BF1' | '\u1C2C' | '\u1C2D' | '\u1C2E' | '\u1C2F' | '\u1C30' | '\u1C31' | '\u1C32' | '\u1C33' | '\u1C36' | '\u1C37' | '\u1CD0' | '\u1CD1' | '\u1CD2' | '\u1CD4' | '\u1CD5' | '\u1CD6' | '\u1CD7' | '\u1CD8' | '\u1CD9' | '\u1CDA' | '\u1CDB' | '\u1CDC' | '\u1CDD' | '\u1CDE' | '\u1CDF' | '\u1CE0' | '\u1CE2' | '\u1CE3' | '\u1CE4' | '\u1CE5' | '\u1CE6' | '\u1CE7' | '\u1CE8' | '\u1CED' | '\u1CF4' | '\u1CF8' | '\u1CF9' | '\u1DC0' | '\u1DC1' | '\u1DC2' | '\u1DC3' | '\u1DC4' | '\u1DC5' | '\u1DC6' | '\u1DC7' | '\u1DC8' | '\u1DC9' | '\u1DCA' | '\u1DCB' | '\u1DCC' | '\u1DCD' | '\u1DCE' | '\u1DCF' | '\u1DD0' | '\u1DD1' | '\u1DD2' | '\u1DD3' | '\u1DD4' | '\u1DD5' | '\u1DD6' | '\u1DD7' | '\u1DD8' | '\u1DD9' | '\u1DDA' | '\u1DDB' | '\u1DDC' | '\u1DDD' | '\u1DDE' | '\u1DDF' | '\u1DE0' | '\u1DE1' | '\u1DE2' | '\u1DE3' | '\u1DE4' | '\u1DE5' | '\u1DE6' | '\u1DE7' | '\u1DE8' | '\u1DE9' | '\u1DEA' | '\u1DEB' | '\u1DEC' | '\u1DED' | '\u1DEE' | '\u1DEF' | '\u1DF0' | '\u1DF1' | '\u1DF2' | '\u1DF3' | '\u1DF4' | '\u1DF5' | '\u1DF6' | '\u1DF7' | '\u1DF8' | '\u1DF9' | '\u1DFB' | '\u1DFC' | '\u1DFD' | '\u1DFE' | '\u1DFF' | '\u20D0' | '\u20D1' | '\u20D2' | '\u20D3' | '\u20D4' | '\u20D5' | '\u20D6' | '\u20D7' | '\u20D8' | '\u20D9' | '\u20DA' | '\u20DB' | '\u20DC' | '\u20E1' | '\u20E5' | '\u20E6' | '\u20E7' | '\u20E8' | '\u20E9' | '\u20EA' | '\u20EB' | '\u20EC' | '\u20ED' | '\u20EE' | '\u20EF' | '\u20F0' | '\u2CEF' | '\u2CF0' | '\u2CF1' | '\u2D7F' | '\u2DE0' | '\u2DE1' | '\u2DE2' | '\u2DE3' | '\u2DE4' | '\u2DE5' | '\u2DE6' | '\u2DE7' | '\u2DE8' | '\u2DE9' | '\u2DEA' | '\u2DEB' | '\u2DEC' | '\u2DED' | '\u2DEE' | '\u2DEF' | '\u2DF0' | '\u2DF1' | '\u2DF2' | '\u2DF3' | '\u2DF4' | '\u2DF5' | '\u2DF6' | '\u2DF7' | '\u2DF8' | '\u2DF9' | '\u2DFA' | '\u2DFB' | '\u2DFC' | '\u2DFD' | '\u2DFE' | '\u2DFF' | '\u302A' | '\u302B' | '\u302C' | '\u302D' | '\u3099' | '\u309A' | '\uA66F' | '\uA674' | '\uA675' | '\uA676' | '\uA677' | '\uA678' | '\uA679' | '\uA67A' | '\uA67B' | '\uA67C' | '\uA67D' | '\uA69E' | '\uA69F' | '\uA6F0' | '\uA6F1' | '\uA802' | '\uA806' | '\uA80B' | '\uA825' | '\uA826' | '\uA8C4' | '\uA8C5' | '\uA8E0' | '\uA8E1' | '\uA8E2' | '\uA8E3' | '\uA8E4' | '\uA8E5' | '\uA8E6' | '\uA8E7' | '\uA8E8' | '\uA8E9' | '\uA8EA' | '\uA8EB' | '\uA8EC' | '\uA8ED' | '\uA8EE' | '\uA8EF' | '\uA8F0' | '\uA8F1' | '\uA926' | '\uA927' | '\uA928' | '\uA929' | '\uA92A' | '\uA92B' | '\uA92C' | '\uA92D' | '\uA947' | '\uA948' | '\uA949' | '\uA94A' | '\uA94B' | '\uA94C' | '\uA94D' | '\uA94E' | '\uA94F' | '\uA950' | '\uA951' | '\uA980' | '\uA981' | '\uA982' | '\uA9B3' | '\uA9B6' | '\uA9B7' | '\uA9B8' | '\uA9B9' | '\uA9BC' | '\uA9E5' | '\uAA29' | '\uAA2A' | '\uAA2B' | '\uAA2C' | '\uAA2D' | '\uAA2E' | '\uAA31' | '\uAA32' | '\uAA35' | '\uAA36' | '\uAA43' | '\uAA4C' | '\uAA7C' | '\uAAB0' | '\uAAB2' | '\uAAB3' | '\uAAB4' | '\uAAB7' | '\uAAB8' | '\uAABE' | '\uAABF' | '\uAAC1' | '\uAAEC' | '\uAAED' | '\uAAF6' | '\uABE5' | '\uABE8' | '\uABED' | '\uFB1E' | '\uFE00' | '\uFE01' | '\uFE02' | '\uFE03' | '\uFE04' | '\uFE05' | '\uFE06' | '\uFE07' | '\uFE08' | '\uFE09' | '\uFE0A' | '\uFE0B' | '\uFE0C' | '\uFE0D' | '\uFE0E' | '\uFE0F' | '\uFE20' | '\uFE21' | '\uFE22' | '\uFE23' | '\uFE24' | '\uFE25' | '\uFE26' | '\uFE27' | '\uFE28' | '\uFE29' | '\uFE2A' | '\uFE2B' | '\uFE2C' | '\uFE2D' | '\uFE2E' | '\uFE2F' | '\u101FD' | '\u102E0' | '\u10376' | '\u10377' | '\u10378' | '\u10379' | '\u1037A' | '\u10A01' | '\u10A02' | '\u10A03' | '\u10A05' | '\u10A06' | '\u10A0C' | '\u10A0D' | '\u10A0E' | '\u10A0F' | '\u10A38' | '\u10A39' | '\u10A3A' | '\u10A3F' | '\u10AE5' | '\u10AE6' | '\u11001' | '\u11038' | '\u11039' | '\u1103A' | '\u1103B' | '\u1103C' | '\u1103D' | '\u1103E' | '\u1103F' | '\u11040' | '\u11041' | '\u11042' | '\u11043' | '\u11044' | '\u11045' | '\u11046' | '\u1107F' | '\u11080' | '\u11081' | '\u110B3' | '\u110B4' | '\u110B5' | '\u110B6' | '\u110B9' | '\u110BA' | '\u11100' | '\u11101' | '\u11102' | '\u11127' | '\u11128' | '\u11129' | '\u1112A' | '\u1112B' | '\u1112D' | '\u1112E' | '\u1112F' | '\u11130' | '\u11131' | '\u11132' | '\u11133' | '\u11134' | '\u11173' | '\u11180' | '\u11181' | '\u111B6' | '\u111B7' | '\u111B8' | '\u111B9' | '\u111BA' | '\u111BB' | '\u111BC' | '\u111BD' | '\u111BE' | '\u111CA' | '\u111CB' | '\u111CC' | '\u1122F' | '\u11230' | '\u11231' | '\u11234' | '\u11236' | '\u11237' | '\u1123E' | '\u112DF' | '\u112E3' | '\u112E4' | '\u112E5' | '\u112E6' | '\u112E7' | '\u112E8' | '\u112E9' | '\u112EA' | '\u11300' | '\u11301' | '\u1133C' | '\u11340' | '\u11366' | '\u11367' | '\u11368' | '\u11369' | '\u1136A' | '\u1136B' | '\u1136C' | '\u11370' | '\u11371' | '\u11372' | '\u11373' | '\u11374' | '\u11438' | '\u11439' | '\u1143A' | '\u1143B' | '\u1143C' | '\u1143D' | '\u1143E' | '\u1143F' | '\u11442' | '\u11443' | '\u11444' | '\u11446' | '\u114B3' | '\u114B4' | '\u114B5' | '\u114B6' | '\u114B7' | '\u114B8' | '\u114BA' | '\u114BF' | '\u114C0' | '\u114C2' | '\u114C3' | '\u115B2' | '\u115B3' | '\u115B4' | '\u115B5' | '\u115BC' | '\u115BD' | '\u115BF' | '\u115C0' | '\u115DC' | '\u115DD' | '\u11633' | '\u11634' | '\u11635' | '\u11636' | '\u11637' | '\u11638' | '\u11639' | '\u1163A' | '\u1163D' | '\u1163F' | '\u11640' | '\u116AB' | '\u116AD' | '\u116B0' | '\u116B1' | '\u116B2' | '\u116B3' | '\u116B4' | '\u116B5' | '\u116B7' | '\u1171D' | '\u1171E' | '\u1171F' | '\u11722' | '\u11723' | '\u11724' | '\u11725' | '\u11727' | '\u11728' | '\u11729' | '\u1172A' | '\u1172B' | '\u11A01' | '\u11A02' | '\u11A03' | '\u11A04' | '\u11A05' | '\u11A06' | '\u11A09' | '\u11A0A' | '\u11A33' | '\u11A34' | '\u11A35' | '\u11A36' | '\u11A37' | '\u11A38' | '\u11A3B' | '\u11A3C' | '\u11A3D' | '\u11A3E' | '\u11A47' | '\u11A51' | '\u11A52' | '\u11A53' | '\u11A54' | '\u11A55' | '\u11A56' | '\u11A59' | '\u11A5A' | '\u11A5B' | '\u11A8A' | '\u11A8B' | '\u11A8C' | '\u11A8D' | '\u11A8E' | '\u11A8F' | '\u11A90' | '\u11A91' | '\u11A92' | '\u11A93' | '\u11A94' | '\u11A95' | '\u11A96' | '\u11A98' | '\u11A99' | '\u11C30' | '\u11C31' | '\u11C32' | '\u11C33' | '\u11C34' | '\u11C35' | '\u11C36' | '\u11C38' | '\u11C39' | '\u11C3A' | '\u11C3B' | '\u11C3C' | '\u11C3D' | '\u11C3F' | '\u11C92' | '\u11C93' | '\u11C94' | '\u11C95' | '\u11C96' | '\u11C97' | '\u11C98' | '\u11C99' | '\u11C9A' | '\u11C9B' | '\u11C9C' | '\u11C9D' | '\u11C9E' | '\u11C9F' | '\u11CA0' | '\u11CA1' | '\u11CA2' | '\u11CA3' | '\u11CA4' | '\u11CA5' | '\u11CA6' | '\u11CA7' | '\u11CAA' | '\u11CAB' | '\u11CAC' | '\u11CAD' | '\u11CAE' | '\u11CAF' | '\u11CB0' | '\u11CB2' | '\u11CB3' | '\u11CB5' | '\u11CB6' | '\u11D31' | '\u11D32' | '\u11D33' | '\u11D34' | '\u11D35' | '\u11D36' | '\u11D3A' | '\u11D3C' | '\u11D3D' | '\u11D3F' | '\u11D40' | '\u11D41' | '\u11D42' | '\u11D43' | '\u11D44' | '\u11D45' | '\u11D47' | '\u16AF0' | '\u16AF1' | '\u16AF2' | '\u16AF3' | '\u16AF4' | '\u16B30' | '\u16B31' | '\u16B32' | '\u16B33' | '\u16B34' | '\u16B35' | '\u16B36' | '\u16F8F' | '\u16F90' | '\u16F91' | '\u16F92' | '\u1BC9D' | '\u1BC9E' | '\u1D167' | '\u1D168' | '\u1D169' | '\u1D17B' | '\u1D17C' | '\u1D17D' | '\u1D17E' | '\u1D17F' | '\u1D180' | '\u1D181' | '\u1D182' | '\u1D185' | '\u1D186' | '\u1D187' | '\u1D188' | '\u1D189' | '\u1D18A' | '\u1D18B' | '\u1D1AA' | '\u1D1AB' | '\u1D1AC' | '\u1D1AD' | '\u1D242' | '\u1D243' | '\u1D244' | '\u1DA00' | '\u1DA01' | '\u1DA02' | '\u1DA03' | '\u1DA04' | '\u1DA05' | '\u1DA06' | '\u1DA07' | '\u1DA08' | '\u1DA09' | '\u1DA0A' | '\u1DA0B' | '\u1DA0C' | '\u1DA0D' | '\u1DA0E' | '\u1DA0F' | '\u1DA10' | '\u1DA11' | '\u1DA12' | '\u1DA13' | '\u1DA14' | '\u1DA15' | '\u1DA16' | '\u1DA17' | '\u1DA18' | '\u1DA19' | '\u1DA1A' | '\u1DA1B' | '\u1DA1C' | '\u1DA1D' | '\u1DA1E' | '\u1DA1F' | '\u1DA20' | '\u1DA21' | '\u1DA22' | '\u1DA23' | '\u1DA24' | '\u1DA25' | '\u1DA26' | '\u1DA27' | '\u1DA28' | '\u1DA29' | '\u1DA2A' | '\u1DA2B' | '\u1DA2C' | '\u1DA2D' | '\u1DA2E' | '\u1DA2F' | '\u1DA30' | '\u1DA31' | '\u1DA32' | '\u1DA33' | '\u1DA34' | '\u1DA35' | '\u1DA36' | '\u1DA3B' | '\u1DA3C' | '\u1DA3D' | '\u1DA3E' | '\u1DA3F' | '\u1DA40' | '\u1DA41' | '\u1DA42' | '\u1DA43' | '\u1DA44' | '\u1DA45' | '\u1DA46' | '\u1DA47' | '\u1DA48' | '\u1DA49' | '\u1DA4A' | '\u1DA4B' | '\u1DA4C' | '\u1DA4D' | '\u1DA4E' | '\u1DA4F' | '\u1DA50' | '\u1DA51' | '\u1DA52' | '\u1DA53' | '\u1DA54' | '\u1DA55' | '\u1DA56' | '\u1DA57' | '\u1DA58' | '\u1DA59' | '\u1DA5A' | '\u1DA5B' | '\u1DA5C' | '\u1DA5D' | '\u1DA5E' | '\u1DA5F' | '\u1DA60' | '\u1DA61' | '\u1DA62' | '\u1DA63' | '\u1DA64' | '\u1DA65' | '\u1DA66' | '\u1DA67' | '\u1DA68' | '\u1DA69' | '\u1DA6A' | '\u1DA6B' | '\u1DA6C' | '\u1DA75' | '\u1DA84' | '\u1DA9B' | '\u1DA9C' | '\u1DA9D' | '\u1DA9E' | '\u1DA9F' | '\u1DAA1' | '\u1DAA2' | '\u1DAA3' | '\u1DAA4' | '\u1DAA5' | '\u1DAA6' | '\u1DAA7' | '\u1DAA8' | '\u1DAA9' | '\u1DAAA' | '\u1DAAB' | '\u1DAAC' | '\u1DAAD' | '\u1DAAE' | '\u1DAAF' | '\u1E000' | '\u1E001' | '\u1E002' | '\u1E003' | '\u1E004' | '\u1E005' | '\u1E006' | '\u1E008' | '\u1E009' | '\u1E00A' | '\u1E00B' | '\u1E00C' | '\u1E00D' | '\u1E00E' | '\u1E00F' | '\u1E010' | '\u1E011' | '\u1E012' | '\u1E013' | '\u1E014' | '\u1E015' | '\u1E016' | '\u1E017' | '\u1E018' | '\u1E01B' | '\u1E01C' | '\u1E01D' | '\u1E01E' | '\u1E01F' | '\u1E020' | '\u1E021' | '\u1E023' | '\u1E024' | '\u1E026' | '\u1E027' | '\u1E028' | '\u1E029' | '\u1E02A' | '\u1E8D0' | '\u1E8D1' | '\u1E8D2' | '\u1E8D3' | '\u1E8D4' | '\u1E8D5' | '\u1E8D6' | '\u1E944' | '\u1E945' | '\u1E946' | '\u1E947' | '\u1E948' | '\u1E949' | '\u1E94A' | '\uE0100' | '\uE0101' | '\uE0102' | '\uE0103' | '\uE0104' | '\uE0105' | '\uE0106' | '\uE0107' | '\uE0108' | '\uE0109' | '\uE010A' | '\uE010B' | '\uE010C' | '\uE010D' | '\uE010E' | '\uE010F' | '\uE0110' | '\uE0111' | '\uE0112' | '\uE0113' | '\uE0114' | '\uE0115' | '\uE0116' | '\uE0117' | '\uE0118' | '\uE0119' | '\uE011A' | '\uE011B' | '\uE011C' | '\uE011D' | '\uE011E' | '\uE011F' | '\uE0120' | '\uE0121' | '\uE0122' | '\uE0123' | '\uE0124' | '\uE0125' | '\uE0126' | '\uE0127' | '\uE0128' | '\uE0129' | '\uE012A' | '\uE012B' | '\uE012C' | '\uE012D' | '\uE012E' | '\uE012F' | '\uE0130' | '\uE0131' | '\uE0132' | '\uE0133' | '\uE0134' | '\uE0135' | '\uE0136' | '\uE0137' | '\uE0138' | '\uE0139' | '\uE013A' | '\uE013B' | '\uE013C' | '\uE013D' | '\uE013E' | '\uE013F' | '\uE0140' | '\uE0141' | '\uE0142' | '\uE0143' | '\uE0144' | '\uE0145' | '\uE0146' | '\uE0147' | '\uE0148' | '\uE0149' | '\uE014A' | '\uE014B' | '\uE014C' | '\uE014D' | '\uE014E' | '\uE014F' | '\uE0150' | '\uE0151' | '\uE0152' | '\uE0153' | '\uE0154' | '\uE0155' | '\uE0156' | '\uE0157' | '\uE0158' | '\uE0159' | '\uE015A' | '\uE015B' | '\uE015C' | '\uE015D' | '\uE015E' | '\uE015F' | '\uE0160' | '\uE0161' | '\uE0162' | '\uE0163' | '\uE0164' | '\uE0165' | '\uE0166' | '\uE0167' | '\uE0168' | '\uE0169' | '\uE016A' | '\uE016B' | '\uE016C' | '\uE016D' | '\uE016E' | '\uE016F' | '\uE0170' | '\uE0171' | '\uE0172' | '\uE0173' | '\uE0174' | '\uE0175' | '\uE0176' | '\uE0177' | '\uE0178' | '\uE0179' | '\uE017A' | '\uE017B' | '\uE017C' | '\uE017D' | '\uE017E' | '\uE017F' | '\uE0180' | '\uE0181' | '\uE0182' | '\uE0183' | '\uE0184' | '\uE0185' | '\uE0186' | '\uE0187' | '\uE0188' | '\uE0189' | '\uE018A' | '\uE018B' | '\uE018C' | '\uE018D' | '\uE018E' | '\uE018F' | '\uE0190' | '\uE0191' | '\uE0192' | '\uE0193' | '\uE0194' | '\uE0195' | '\uE0196' | '\uE0197' | '\uE0198' | '\uE0199' | '\uE019A' | '\uE019B' | '\uE019C' | '\uE019D' | '\uE019E' | '\uE019F' | '\uE01A0' | '\uE01A1' | '\uE01A2' | '\uE01A3' | '\uE01A4' | '\uE01A5' | '\uE01A6' | '\uE01A7' | '\uE01A8' | '\uE01A9' | '\uE01AA' | '\uE01AB' | '\uE01AC' | '\uE01AD' | '\uE01AE' | '\uE01AF' | '\uE01B0' | '\uE01B1' | '\uE01B2' | '\uE01B3' | '\uE01B4' | '\uE01B5' | '\uE01B6' | '\uE01B7' | '\uE01B8' | '\uE01B9' | '\uE01BA' | '\uE01BB' | '\uE01BC' | '\uE01BD' | '\uE01BE' | '\uE01BF' | '\uE01C0' | '\uE01C1' | '\uE01C2' | '\uE01C3' | '\uE01C4' | '\uE01C5' | '\uE01C6' | '\uE01C7' | '\uE01C8' | '\uE01C9' | '\uE01CA' | '\uE01CB' | '\uE01CC' | '\uE01CD' | '\uE01CE' | '\uE01CF' | '\uE01D0' | '\uE01D1' | '\uE01D2' | '\uE01D3' | '\uE01D4' | '\uE01D5' | '\uE01D6' | '\uE01D7' | '\uE01D8' | '\uE01D9' | '\uE01DA' | '\uE01DB' | '\uE01DC' | '\uE01DD' | '\uE01DE' | '\uE01DF' | '\uE01E0' | '\uE01E1' | '\uE01E2' | '\uE01E3' | '\uE01E4' | '\uE01E5' | '\uE01E6' | '\uE01E7' | '\uE01E8' | '\uE01E9' | '\uE01EA' | '\uE01EB' | '\uE01EC' | '\uE01ED' | '\uE01EE' | '\uE01EF' | '\u0903' | '\u093B' | '\u093E' | '\u093F' | '\u0940' | '\u0949' | '\u094A' | '\u094B' | '\u094C' | '\u094E' | '\u094F' | '\u0982' | '\u0983' | '\u09BE' | '\u09BF' | '\u09C0' | '\u09C7' | '\u09C8' | '\u09CB' | '\u09CC' | '\u09D7' | '\u0A03' | '\u0A3E' | '\u0A3F' | '\u0A40' | '\u0A83' | '\u0ABE' | '\u0ABF' | '\u0AC0' | '\u0AC9' | '\u0ACB' | '\u0ACC' | '\u0B02' | '\u0B03' | '\u0B3E' | '\u0B40' | '\u0B47' | '\u0B48' | '\u0B4B' | '\u0B4C' | '\u0B57' | '\u0BBE' | '\u0BBF' | '\u0BC1' | '\u0BC2' | '\u0BC6' | '\u0BC7' | '\u0BC8' | '\u0BCA' | '\u0BCB' | '\u0BCC' | '\u0BD7' | '\u0C01' | '\u0C02' | '\u0C03' | '\u0C41' | '\u0C42' | '\u0C43' | '\u0C44' | '\u0C82' | '\u0C83' | '\u0CBE' | '\u0CC0' | '\u0CC1' | '\u0CC2' | '\u0CC3' | '\u0CC4' | '\u0CC7' | '\u0CC8' | '\u0CCA' | '\u0CCB' | '\u0CD5' | '\u0CD6' | '\u0D02' | '\u0D03' | '\u0D3E' | '\u0D3F' | '\u0D40' | '\u0D46' | '\u0D47' | '\u0D48' | '\u0D4A' | '\u0D4B' | '\u0D4C' | '\u0D57' | '\u0D82' | '\u0D83' | '\u0DCF' | '\u0DD0' | '\u0DD1' | '\u0DD8' | '\u0DD9' | '\u0DDA' | '\u0DDB' | '\u0DDC' | '\u0DDD' | '\u0DDE' | '\u0DDF' | '\u0DF2' | '\u0DF3' | '\u0F3E' | '\u0F3F' | '\u0F7F' | '\u102B' | '\u102C' | '\u1031' | '\u1038' | '\u103B' | '\u103C' | '\u1056' | '\u1057' | '\u1062' | '\u1063' | '\u1064' | '\u1067' | '\u1068' | '\u1069' | '\u106A' | '\u106B' | '\u106C' | '\u106D' | '\u1083' | '\u1084' | '\u1087' | '\u1088' | '\u1089' | '\u108A' | '\u108B' | '\u108C' | '\u108F' | '\u109A' | '\u109B' | '\u109C' | '\u17B6' | '\u17BE' | '\u17BF' | '\u17C0' | '\u17C1' | '\u17C2' | '\u17C3' | '\u17C4' | '\u17C5' | '\u17C7' | '\u17C8' | '\u1923' | '\u1924' | '\u1925' | '\u1926' | '\u1929' | '\u192A' | '\u192B' | '\u1930' | '\u1931' | '\u1933' | '\u1934' | '\u1935' | '\u1936' | '\u1937' | '\u1938' | '\u1A19' | '\u1A1A' | '\u1A55' | '\u1A57' | '\u1A61' | '\u1A63' | '\u1A64' | '\u1A6D' | '\u1A6E' | '\u1A6F' | '\u1A70' | '\u1A71' | '\u1A72' | '\u1B04' | '\u1B35' | '\u1B3B' | '\u1B3D' | '\u1B3E' | '\u1B3F' | '\u1B40' | '\u1B41' | '\u1B43' | '\u1B44' | '\u1B82' | '\u1BA1' | '\u1BA6' | '\u1BA7' | '\u1BAA' | '\u1BE7' | '\u1BEA' | '\u1BEB' | '\u1BEC' | '\u1BEE' | '\u1BF2' | '\u1BF3' | '\u1C24' | '\u1C25' | '\u1C26' | '\u1C27' | '\u1C28' | '\u1C29' | '\u1C2A' | '\u1C2B' | '\u1C34' | '\u1C35' | '\u1CE1' | '\u1CF2' | '\u1CF3' | '\u1CF7' | '\u302E' | '\u302F' | '\uA823' | '\uA824' | '\uA827' | '\uA880' | '\uA881' | '\uA8B4' | '\uA8B5' | '\uA8B6' | '\uA8B7' | '\uA8B8' | '\uA8B9' | '\uA8BA' | '\uA8BB' | '\uA8BC' | '\uA8BD' | '\uA8BE' | '\uA8BF' | '\uA8C0' | '\uA8C1' | '\uA8C2' | '\uA8C3' | '\uA952' | '\uA953' | '\uA983' | '\uA9B4' | '\uA9B5' | '\uA9BA' | '\uA9BB' | '\uA9BD' | '\uA9BE' | '\uA9BF' | '\uA9C0' | '\uAA2F' | '\uAA30' | '\uAA33' | '\uAA34' | '\uAA4D' | '\uAA7B' | '\uAA7D' | '\uAAEB' | '\uAAEE' | '\uAAEF' | '\uAAF5' | '\uABE3' | '\uABE4' | '\uABE6' | '\uABE7' | '\uABE9' | '\uABEA' | '\uABEC' | '\u11000' | '\u11002' | '\u11082' | '\u110B0' | '\u110B1' | '\u110B2' | '\u110B7' | '\u110B8' | '\u1112C' | '\u11182' | '\u111B3' | '\u111B4' | '\u111B5' | '\u111BF' | '\u111C0' | '\u1122C' | '\u1122D' | '\u1122E' | '\u11232' | '\u11233' | '\u11235' | '\u112E0' | '\u112E1' | '\u112E2' | '\u11302' | '\u11303' | '\u1133E' | '\u1133F' | '\u11341' | '\u11342' | '\u11343' | '\u11344' | '\u11347' | '\u11348' | '\u1134B' | '\u1134C' | '\u1134D' | '\u11357' | '\u11362' | '\u11363' | '\u11435' | '\u11436' | '\u11437' | '\u11440' | '\u11441' | '\u11445' | '\u114B0' | '\u114B1' | '\u114B2' | '\u114B9' | '\u114BB' | '\u114BC' | '\u114BD' | '\u114BE' | '\u114C1' | '\u115AF' | '\u115B0' | '\u115B1' | '\u115B8' | '\u115B9' | '\u115BA' | '\u115BB' | '\u115BE' | '\u11630' | '\u11631' | '\u11632' | '\u1163B' | '\u1163C' | '\u1163E' | '\u116AC' | '\u116AE' | '\u116AF' | '\u116B6' | '\u11720' | '\u11721' | '\u11726' | '\u11A07' | '\u11A08' | '\u11A39' | '\u11A57' | '\u11A58' | '\u11A97' | '\u11C2F' | '\u11C3E' | '\u11CA9' | '\u11CB1' | '\u11CB4' | '\u16F51' | '\u16F52' | '\u16F53' | '\u16F54' | '\u16F55' | '\u16F56' | '\u16F57' | '\u16F58' | '\u16F59' | '\u16F5A' | '\u16F5B' | '\u16F5C' | '\u16F5D' | '\u16F5E' | '\u16F5F' | '\u16F60' | '\u16F61' | '\u16F62' | '\u16F63' | '\u16F64' | '\u16F65' | '\u16F66' | '\u16F67' | '\u16F68' | '\u16F69' | '\u16F6A' | '\u16F6B' | '\u16F6C' | '\u16F6D' | '\u16F6E' | '\u16F6F' | '\u16F70' | '\u16F71' | '\u16F72' | '\u16F73' | '\u16F74' | '\u16F75' | '\u16F76' | '\u16F77' | '\u16F78' | '\u16F79' | '\u16F7A' | '\u16F7B' | '\u16F7C' | '\u16F7D' | '\u16F7E' | '\u1D165' | '\u1D166' | '\u1D16D' | '\u1D16E' | '\u1D16F' | '\u1D170' | '\u1D171' | '\u1D172' )
	;

fragment FormattingCharacter
	: ( '\u00AD' | '\u0600' | '\u0601' | '\u0602' | '\u0603' | '\u0604' | '\u0605' | '\u061C' | '\u06DD' | '\u070F' | '\u08E2' | '\u180E' | '\u200B' | '\u200C' | '\u200D' | '\u200E' | '\u200F' | '\u202A' | '\u202B' | '\u202C' | '\u202D' | '\u202E' | '\u2060' | '\u2061' | '\u2062' | '\u2063' | '\u2064' | '\u2066' | '\u2067' | '\u2068' | '\u2069' | '\u206A' | '\u206B' | '\u206C' | '\u206D' | '\u206E' | '\u206F' | '\uFEFF' | '\uFFF9' | '\uFFFA' | '\uFFFB' | '\u110BD' | '\u1BCA0' | '\u1BCA1' | '\u1BCA2' | '\u1BCA3' | '\u1D173' | '\u1D174' | '\u1D175' | '\u1D176' | '\u1D177' | '\u1D178' | '\u1D179' | '\u1D17A' | '\uE0001' | '\uE0020' | '\uE0021' | '\uE0022' | '\uE0023' | '\uE0024' | '\uE0025' | '\uE0026' | '\uE0027' | '\uE0028' | '\uE0029' | '\uE002A' | '\uE002B' | '\uE002C' | '\uE002D' | '\uE002E' | '\uE002F' | '\uE0030' | '\uE0031' | '\uE0032' | '\uE0033' | '\uE0034' | '\uE0035' | '\uE0036' | '\uE0037' | '\uE0038' | '\uE0039' | '\uE003A' | '\uE003B' | '\uE003C' | '\uE003D' | '\uE003E' | '\uE003F' | '\uE0040' | '\uE0041' | '\uE0042' | '\uE0043' | '\uE0044' | '\uE0045' | '\uE0046' | '\uE0047' | '\uE0048' | '\uE0049' | '\uE004A' | '\uE004B' | '\uE004C' | '\uE004D' | '\uE004E' | '\uE004F' | '\uE0050' | '\uE0051' | '\uE0052' | '\uE0053' | '\uE0054' | '\uE0055' | '\uE0056' | '\uE0057' | '\uE0058' | '\uE0059' | '\uE005A' | '\uE005B' | '\uE005C' | '\uE005D' | '\uE005E' | '\uE005F' | '\uE0060' | '\uE0061' | '\uE0062' | '\uE0063' | '\uE0064' | '\uE0065' | '\uE0066' | '\uE0067' | '\uE0068' | '\uE0069' | '\uE006A' | '\uE006B' | '\uE006C' | '\uE006D' | '\uE006E' | '\uE006F' | '\uE0070' | '\uE0071' | '\uE0072' | '\uE0073' | '\uE0074' | '\uE0075' | '\uE0076' | '\uE0077' | '\uE0078' | '\uE0079' | '\uE007A' | '\uE007B' | '\uE007C' | '\uE007D' | '\uE007E' | '\uE007F' )
	;

fragment AnyUnicodeCpLessQuotes
	: ~( '[' | ']' )
	;

fragment IdentifierStartCharacter
	: ( LetterCharacter | UnderscoreCharacter )
	;

fragment IdentifierPartCharacter
	: LetterCharacter
	| NumberCharacter
	| ConnectingCharacter
	| CombiningCharacter
	| FormattingCharacter
	;

UnquotedIdentifier
	: IdentifierStartCharacter ( IdentifierStartCharacter | IdentifierPartCharacter )*
	;

QuotedIdentifier
	: '[' ( LetterCharacter | NumberCharacter | ConnectingCharacter | CombiningCharacter | AnyUnicodeCpLessQuotes | EscapedQuote ) ( LetterCharacter | NumberCharacter | ConnectingCharacter | CombiningCharacter | AnyUnicodeCpLessQuotes | EscapedQuote )* ']'
	;

SystemVariable
	: '@@' UnquotedIdentifier
	;

UserVariable
	: '@' UnquotedIdentifier
	;

DOT
	: '.'
	;

SEMICOLON
	: ';'
	;

QUESTIONMARK
	: '?'
	;

LPAREN
	: '('
	;

RPAREN
	: ')'
	;

COMMA
	: ','
	;

EQUALS
	: '='
	;

PLUS:			'+';
MINUS:			'-';
GT:				'>';
LT:				'<';
LCURLY:			'{';
RCURLY:			'}';
COLON:			':';