<xsl:transform version="2.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xd="http://www.pnp-software.com/XSLTdoc"
   xmlns:sio="http://semanticscience.org/resource/">

<xd:doc type="stylesheet">
   <xd:short>Vocabulary terms.</xd:short>
   <xd:detail></xd:detail>
   <xd:author>Timothy Lebo</xd:author>
   <xd:copyright></xd:copyright>
   <xd:svnId></xd:svnId>
</xd:doc>

<!-- The namespace itself -->
<xsl:variable name="sio"                select="'http://semanticscience.org/resource/'"/>

<!-- Terms within the namespace -->
<xsl:variable name="sio:SIO_000000"    select="concat($sio,'SIO_000000')"/>
<xsl:variable name="sio:SIO_000001"    select="concat($sio,'SIO_000001')"/>
<xsl:variable name="sio:SIO_000004"    select="concat($sio,'SIO_000004')"/>
<xsl:variable name="sio:SIO_000005"    select="concat($sio,'SIO_000005')"/>
<xsl:variable name="sio:SIO_000006"    select="concat($sio,'SIO_000006')"/>
<xsl:variable name="sio:SIO_000008"    select="concat($sio,'SIO_000008')"/>
<xsl:variable name="sio:SIO_000009"    select="concat($sio,'SIO_000009')"/>
<xsl:variable name="sio:SIO_000010"    select="concat($sio,'SIO_000010')"/>
<xsl:variable name="sio:SIO_000011"    select="concat($sio,'SIO_000011')"/>
<xsl:variable name="sio:SIO_000012"    select="concat($sio,'SIO_000012')"/>
<xsl:variable name="sio:SIO_000013"    select="concat($sio,'SIO_000013')"/>
<xsl:variable name="sio:SIO_000014"    select="concat($sio,'SIO_000014')"/>
<xsl:variable name="sio:SIO_000015"    select="concat($sio,'SIO_000015')"/>
<xsl:variable name="sio:SIO_000016"    select="concat($sio,'SIO_000016')"/>
<xsl:variable name="sio:SIO_000017"    select="concat($sio,'SIO_000017')"/>
<xsl:variable name="sio:SIO_000019"    select="concat($sio,'SIO_000019')"/>
<xsl:variable name="sio:SIO_000020"    select="concat($sio,'SIO_000020')"/>
<xsl:variable name="sio:SIO_000022"    select="concat($sio,'SIO_000022')"/>
<xsl:variable name="sio:SIO_000026"    select="concat($sio,'SIO_000026')"/>
<xsl:variable name="sio:SIO_000027"    select="concat($sio,'SIO_000027')"/>
<xsl:variable name="sio:SIO_000028"    select="concat($sio,'SIO_000028')"/>
<xsl:variable name="sio:SIO_000029"    select="concat($sio,'SIO_000029')"/>
<xsl:variable name="sio:SIO_000030"    select="concat($sio,'SIO_000030')"/>
<xsl:variable name="sio:SIO_000031"    select="concat($sio,'SIO_000031')"/>
<xsl:variable name="sio:SIO_000032"    select="concat($sio,'SIO_000032')"/>
<xsl:variable name="sio:SIO_000033"    select="concat($sio,'SIO_000033')"/>
<xsl:variable name="sio:SIO_000034"    select="concat($sio,'SIO_000034')"/>
<xsl:variable name="sio:SIO_000035"    select="concat($sio,'SIO_000035')"/>
<xsl:variable name="sio:SIO_000036"    select="concat($sio,'SIO_000036')"/>
<xsl:variable name="sio:SIO_000037"    select="concat($sio,'SIO_000037')"/>
<xsl:variable name="sio:SIO_000038"    select="concat($sio,'SIO_000038')"/>
<xsl:variable name="sio:SIO_000039"    select="concat($sio,'SIO_000039')"/>
<xsl:variable name="sio:SIO_000040"    select="concat($sio,'SIO_000040')"/>
<xsl:variable name="sio:SIO_000041"    select="concat($sio,'SIO_000041')"/>
<xsl:variable name="sio:SIO_000042"    select="concat($sio,'SIO_000042')"/>
<xsl:variable name="sio:SIO_000043"    select="concat($sio,'SIO_000043')"/>
<xsl:variable name="sio:SIO_000044"    select="concat($sio,'SIO_000044')"/>
<xsl:variable name="sio:SIO_000045"    select="concat($sio,'SIO_000045')"/>
<xsl:variable name="sio:SIO_000046"    select="concat($sio,'SIO_000046')"/>
<xsl:variable name="sio:SIO_000047"    select="concat($sio,'SIO_000047')"/>
<xsl:variable name="sio:SIO_000048"    select="concat($sio,'SIO_000048')"/>
<xsl:variable name="sio:SIO_000049"    select="concat($sio,'SIO_000049')"/>
<xsl:variable name="sio:SIO_000051"    select="concat($sio,'SIO_000051')"/>
<xsl:variable name="sio:SIO_000052"    select="concat($sio,'SIO_000052')"/>
<xsl:variable name="sio:SIO_000053"    select="concat($sio,'SIO_000053')"/>
<xsl:variable name="sio:SIO_000054"    select="concat($sio,'SIO_000054')"/>
<xsl:variable name="sio:SIO_000055"    select="concat($sio,'SIO_000055')"/>
<xsl:variable name="sio:SIO_000056"    select="concat($sio,'SIO_000056')"/>
<xsl:variable name="sio:SIO_000057"    select="concat($sio,'SIO_000057')"/>
<xsl:variable name="sio:SIO_000059"    select="concat($sio,'SIO_000059')"/>
<xsl:variable name="sio:SIO_000060"    select="concat($sio,'SIO_000060')"/>
<xsl:variable name="sio:SIO_000061"    select="concat($sio,'SIO_000061')"/>
<xsl:variable name="sio:SIO_000062"    select="concat($sio,'SIO_000062')"/>
<xsl:variable name="sio:SIO_000063"    select="concat($sio,'SIO_000063')"/>
<xsl:variable name="sio:SIO_000064"    select="concat($sio,'SIO_000064')"/>
<xsl:variable name="sio:SIO_000066"    select="concat($sio,'SIO_000066')"/>
<xsl:variable name="sio:SIO_000067"    select="concat($sio,'SIO_000067')"/>
<xsl:variable name="sio:SIO_000068"    select="concat($sio,'SIO_000068')"/>
<xsl:variable name="sio:SIO_000069"    select="concat($sio,'SIO_000069')"/>
<xsl:variable name="sio:SIO_000070"    select="concat($sio,'SIO_000070')"/>
<xsl:variable name="sio:SIO_000071"    select="concat($sio,'SIO_000071')"/>
<xsl:variable name="sio:SIO_000072"    select="concat($sio,'SIO_000072')"/>
<xsl:variable name="sio:SIO_000073"    select="concat($sio,'SIO_000073')"/>
<xsl:variable name="sio:SIO_000074"    select="concat($sio,'SIO_000074')"/>
<xsl:variable name="sio:SIO_000075"    select="concat($sio,'SIO_000075')"/>
<xsl:variable name="sio:SIO_000076"    select="concat($sio,'SIO_000076')"/>
<xsl:variable name="sio:SIO_000077"    select="concat($sio,'SIO_000077')"/>
<xsl:variable name="sio:SIO_000078"    select="concat($sio,'SIO_000078')"/>
<xsl:variable name="sio:SIO_000079"    select="concat($sio,'SIO_000079')"/>
<xsl:variable name="sio:SIO_000080"    select="concat($sio,'SIO_000080')"/>
<xsl:variable name="sio:SIO_000081"    select="concat($sio,'SIO_000081')"/>
<xsl:variable name="sio:SIO_000082"    select="concat($sio,'SIO_000082')"/>
<xsl:variable name="sio:SIO_000083"    select="concat($sio,'SIO_000083')"/>
<xsl:variable name="sio:SIO_000085"    select="concat($sio,'SIO_000085')"/>
<xsl:variable name="sio:SIO_000087"    select="concat($sio,'SIO_000087')"/>
<xsl:variable name="sio:SIO_000088"    select="concat($sio,'SIO_000088')"/>
<xsl:variable name="sio:SIO_000089"    select="concat($sio,'SIO_000089')"/>
<xsl:variable name="sio:SIO_000090"    select="concat($sio,'SIO_000090')"/>
<xsl:variable name="sio:SIO_000091"    select="concat($sio,'SIO_000091')"/>
<xsl:variable name="sio:SIO_000092"    select="concat($sio,'SIO_000092')"/>
<xsl:variable name="sio:SIO_000093"    select="concat($sio,'SIO_000093')"/>
<xsl:variable name="sio:SIO_000094"    select="concat($sio,'SIO_000094')"/>
<xsl:variable name="sio:SIO_000095"    select="concat($sio,'SIO_000095')"/>
<xsl:variable name="sio:SIO_000096"    select="concat($sio,'SIO_000096')"/>
<xsl:variable name="sio:SIO_000097"    select="concat($sio,'SIO_000097')"/>
<xsl:variable name="sio:SIO_000098"    select="concat($sio,'SIO_000098')"/>
<xsl:variable name="sio:SIO_000099"    select="concat($sio,'SIO_000099')"/>
<xsl:variable name="sio:SIO_000100"    select="concat($sio,'SIO_000100')"/>
<xsl:variable name="sio:SIO_000101"    select="concat($sio,'SIO_000101')"/>
<xsl:variable name="sio:SIO_000102"    select="concat($sio,'SIO_000102')"/>
<xsl:variable name="sio:SIO_000103"    select="concat($sio,'SIO_000103')"/>
<xsl:variable name="sio:SIO_000104"    select="concat($sio,'SIO_000104')"/>
<xsl:variable name="sio:SIO_000105"    select="concat($sio,'SIO_000105')"/>
<xsl:variable name="sio:SIO_000106"    select="concat($sio,'SIO_000106')"/>
<xsl:variable name="sio:SIO_000107"    select="concat($sio,'SIO_000107')"/>
<xsl:variable name="sio:SIO_000108"    select="concat($sio,'SIO_000108')"/>
<xsl:variable name="sio:SIO_000109"    select="concat($sio,'SIO_000109')"/>
<xsl:variable name="sio:SIO_000110"    select="concat($sio,'SIO_000110')"/>
<xsl:variable name="sio:SIO_000111"    select="concat($sio,'SIO_000111')"/>
<xsl:variable name="sio:SIO_000112"    select="concat($sio,'SIO_000112')"/>
<xsl:variable name="sio:SIO_000113"    select="concat($sio,'SIO_000113')"/>
<xsl:variable name="sio:SIO_000114"    select="concat($sio,'SIO_000114')"/>
<xsl:variable name="sio:SIO_000115"    select="concat($sio,'SIO_000115')"/>
<xsl:variable name="sio:SIO_000116"    select="concat($sio,'SIO_000116')"/>
<xsl:variable name="sio:SIO_000117"    select="concat($sio,'SIO_000117')"/>
<xsl:variable name="sio:SIO_000118"    select="concat($sio,'SIO_000118')"/>
<xsl:variable name="sio:SIO_000119"    select="concat($sio,'SIO_000119')"/>
<xsl:variable name="sio:SIO_000120"    select="concat($sio,'SIO_000120')"/>
<xsl:variable name="sio:SIO_000121"    select="concat($sio,'SIO_000121')"/>
<xsl:variable name="sio:SIO_000122"    select="concat($sio,'SIO_000122')"/>
<xsl:variable name="sio:SIO_000123"    select="concat($sio,'SIO_000123')"/>
<xsl:variable name="sio:SIO_000124"    select="concat($sio,'SIO_000124')"/>
<xsl:variable name="sio:SIO_000125"    select="concat($sio,'SIO_000125')"/>
<xsl:variable name="sio:SIO_000126"    select="concat($sio,'SIO_000126')"/>
<xsl:variable name="sio:SIO_000127"    select="concat($sio,'SIO_000127')"/>
<xsl:variable name="sio:SIO_000128"    select="concat($sio,'SIO_000128')"/>
<xsl:variable name="sio:SIO_000129"    select="concat($sio,'SIO_000129')"/>
<xsl:variable name="sio:SIO_000130"    select="concat($sio,'SIO_000130')"/>
<xsl:variable name="sio:SIO_000131"    select="concat($sio,'SIO_000131')"/>
<xsl:variable name="sio:SIO_000132"    select="concat($sio,'SIO_000132')"/>
<xsl:variable name="sio:SIO_000133"    select="concat($sio,'SIO_000133')"/>
<xsl:variable name="sio:SIO_000135"    select="concat($sio,'SIO_000135')"/>
<xsl:variable name="sio:SIO_000136"    select="concat($sio,'SIO_000136')"/>
<xsl:variable name="sio:SIO_000137"    select="concat($sio,'SIO_000137')"/>
<xsl:variable name="sio:SIO_000138"    select="concat($sio,'SIO_000138')"/>
<xsl:variable name="sio:SIO_000139"    select="concat($sio,'SIO_000139')"/>
<xsl:variable name="sio:SIO_000140"    select="concat($sio,'SIO_000140')"/>
<xsl:variable name="sio:SIO_000141"    select="concat($sio,'SIO_000141')"/>
<xsl:variable name="sio:SIO_000142"    select="concat($sio,'SIO_000142')"/>
<xsl:variable name="sio:SIO_000143"    select="concat($sio,'SIO_000143')"/>
<xsl:variable name="sio:SIO_000144"    select="concat($sio,'SIO_000144')"/>
<xsl:variable name="sio:SIO_000145"    select="concat($sio,'SIO_000145')"/>
<xsl:variable name="sio:SIO_000146"    select="concat($sio,'SIO_000146')"/>
<xsl:variable name="sio:SIO_000147"    select="concat($sio,'SIO_000147')"/>
<xsl:variable name="sio:SIO_000148"    select="concat($sio,'SIO_000148')"/>
<xsl:variable name="sio:SIO_000150"    select="concat($sio,'SIO_000150')"/>
<xsl:variable name="sio:SIO_000151"    select="concat($sio,'SIO_000151')"/>
<xsl:variable name="sio:SIO_000152"    select="concat($sio,'SIO_000152')"/>
<xsl:variable name="sio:SIO_000153"    select="concat($sio,'SIO_000153')"/>
<xsl:variable name="sio:SIO_000154"    select="concat($sio,'SIO_000154')"/>
<xsl:variable name="sio:SIO_000155"    select="concat($sio,'SIO_000155')"/>
<xsl:variable name="sio:SIO_000156"    select="concat($sio,'SIO_000156')"/>
<xsl:variable name="sio:SIO_000157"    select="concat($sio,'SIO_000157')"/>
<xsl:variable name="sio:SIO_000158"    select="concat($sio,'SIO_000158')"/>
<xsl:variable name="sio:SIO_000159"    select="concat($sio,'SIO_000159')"/>
<xsl:variable name="sio:SIO_000160"    select="concat($sio,'SIO_000160')"/>
<xsl:variable name="sio:SIO_000161"    select="concat($sio,'SIO_000161')"/>
<xsl:variable name="sio:SIO_000162"    select="concat($sio,'SIO_000162')"/>
<xsl:variable name="sio:SIO_000163"    select="concat($sio,'SIO_000163')"/>
<xsl:variable name="sio:SIO_000164"    select="concat($sio,'SIO_000164')"/>
<xsl:variable name="sio:SIO_000165"    select="concat($sio,'SIO_000165')"/>
<xsl:variable name="sio:SIO_000166"    select="concat($sio,'SIO_000166')"/>
<xsl:variable name="sio:SIO_000167"    select="concat($sio,'SIO_000167')"/>
<xsl:variable name="sio:SIO_000168"    select="concat($sio,'SIO_000168')"/>
<xsl:variable name="sio:SIO_000169"    select="concat($sio,'SIO_000169')"/>
<xsl:variable name="sio:SIO_000170"    select="concat($sio,'SIO_000170')"/>
<xsl:variable name="sio:SIO_000171"    select="concat($sio,'SIO_000171')"/>
<xsl:variable name="sio:SIO_000172"    select="concat($sio,'SIO_000172')"/>
<xsl:variable name="sio:SIO_000173"    select="concat($sio,'SIO_000173')"/>
<xsl:variable name="sio:SIO_000174"    select="concat($sio,'SIO_000174')"/>
<xsl:variable name="sio:SIO_000175"    select="concat($sio,'SIO_000175')"/>
<xsl:variable name="sio:SIO_000176"    select="concat($sio,'SIO_000176')"/>
<xsl:variable name="sio:SIO_000177"    select="concat($sio,'SIO_000177')"/>
<xsl:variable name="sio:SIO_000178"    select="concat($sio,'SIO_000178')"/>
<xsl:variable name="sio:SIO_000179"    select="concat($sio,'SIO_000179')"/>
<xsl:variable name="sio:SIO_000180"    select="concat($sio,'SIO_000180')"/>
<xsl:variable name="sio:SIO_000181"    select="concat($sio,'SIO_000181')"/>
<xsl:variable name="sio:SIO_000182"    select="concat($sio,'SIO_000182')"/>
<xsl:variable name="sio:SIO_000183"    select="concat($sio,'SIO_000183')"/>
<xsl:variable name="sio:SIO_000184"    select="concat($sio,'SIO_000184')"/>
<xsl:variable name="sio:SIO_000185"    select="concat($sio,'SIO_000185')"/>
<xsl:variable name="sio:SIO_000186"    select="concat($sio,'SIO_000186')"/>
<xsl:variable name="sio:SIO_000188"    select="concat($sio,'SIO_000188')"/>
<xsl:variable name="sio:SIO_000189"    select="concat($sio,'SIO_000189')"/>
<xsl:variable name="sio:SIO_000190"    select="concat($sio,'SIO_000190')"/>
<xsl:variable name="sio:SIO_000191"    select="concat($sio,'SIO_000191')"/>
<xsl:variable name="sio:SIO_000192"    select="concat($sio,'SIO_000192')"/>
<xsl:variable name="sio:SIO_000193"    select="concat($sio,'SIO_000193')"/>
<xsl:variable name="sio:SIO_000194"    select="concat($sio,'SIO_000194')"/>
<xsl:variable name="sio:SIO_000195"    select="concat($sio,'SIO_000195')"/>
<xsl:variable name="sio:SIO_000196"    select="concat($sio,'SIO_000196')"/>
<xsl:variable name="sio:SIO_000197"    select="concat($sio,'SIO_000197')"/>
<xsl:variable name="sio:SIO_000198"    select="concat($sio,'SIO_000198')"/>
<xsl:variable name="sio:SIO_000199"    select="concat($sio,'SIO_000199')"/>
<xsl:variable name="sio:SIO_000200"    select="concat($sio,'SIO_000200')"/>
<xsl:variable name="sio:SIO_000201"    select="concat($sio,'SIO_000201')"/>
<xsl:variable name="sio:SIO_000202"    select="concat($sio,'SIO_000202')"/>
<xsl:variable name="sio:SIO_000203"    select="concat($sio,'SIO_000203')"/>
<xsl:variable name="sio:SIO_000204"    select="concat($sio,'SIO_000204')"/>
<xsl:variable name="sio:SIO_000205"    select="concat($sio,'SIO_000205')"/>
<xsl:variable name="sio:SIO_000206"    select="concat($sio,'SIO_000206')"/>
<xsl:variable name="sio:SIO_000207"    select="concat($sio,'SIO_000207')"/>
<xsl:variable name="sio:SIO_000208"    select="concat($sio,'SIO_000208')"/>
<xsl:variable name="sio:SIO_000209"    select="concat($sio,'SIO_000209')"/>
<xsl:variable name="sio:SIO_000210"    select="concat($sio,'SIO_000210')"/>
<xsl:variable name="sio:SIO_000211"    select="concat($sio,'SIO_000211')"/>
<xsl:variable name="sio:SIO_000212"    select="concat($sio,'SIO_000212')"/>
<xsl:variable name="sio:SIO_000213"    select="concat($sio,'SIO_000213')"/>
<xsl:variable name="sio:SIO_000214"    select="concat($sio,'SIO_000214')"/>
<xsl:variable name="sio:SIO_000215"    select="concat($sio,'SIO_000215')"/>
<xsl:variable name="sio:SIO_000216"    select="concat($sio,'SIO_000216')"/>
<xsl:variable name="sio:SIO_000217"    select="concat($sio,'SIO_000217')"/>
<xsl:variable name="sio:SIO_000218"    select="concat($sio,'SIO_000218')"/>
<xsl:variable name="sio:SIO_000219"    select="concat($sio,'SIO_000219')"/>
<xsl:variable name="sio:SIO_000220"    select="concat($sio,'SIO_000220')"/>
<xsl:variable name="sio:SIO_000221"    select="concat($sio,'SIO_000221')"/>
<xsl:variable name="sio:SIO_000222"    select="concat($sio,'SIO_000222')"/>
<xsl:variable name="sio:SIO_000223"    select="concat($sio,'SIO_000223')"/>
<xsl:variable name="sio:SIO_000224"    select="concat($sio,'SIO_000224')"/>
<xsl:variable name="sio:SIO_000225"    select="concat($sio,'SIO_000225')"/>
<xsl:variable name="sio:SIO_000226"    select="concat($sio,'SIO_000226')"/>
<xsl:variable name="sio:SIO_000227"    select="concat($sio,'SIO_000227')"/>
<xsl:variable name="sio:SIO_000228"    select="concat($sio,'SIO_000228')"/>
<xsl:variable name="sio:SIO_000229"    select="concat($sio,'SIO_000229')"/>
<xsl:variable name="sio:SIO_000230"    select="concat($sio,'SIO_000230')"/>
<xsl:variable name="sio:SIO_000231"    select="concat($sio,'SIO_000231')"/>
<xsl:variable name="sio:SIO_000232"    select="concat($sio,'SIO_000232')"/>
<xsl:variable name="sio:SIO_000233"    select="concat($sio,'SIO_000233')"/>
<xsl:variable name="sio:SIO_000234"    select="concat($sio,'SIO_000234')"/>
<xsl:variable name="sio:SIO_000235"    select="concat($sio,'SIO_000235')"/>
<xsl:variable name="sio:SIO_000236"    select="concat($sio,'SIO_000236')"/>
<xsl:variable name="sio:SIO_000237"    select="concat($sio,'SIO_000237')"/>
<xsl:variable name="sio:SIO_000238"    select="concat($sio,'SIO_000238')"/>
<xsl:variable name="sio:SIO_000239"    select="concat($sio,'SIO_000239')"/>
<xsl:variable name="sio:SIO_000240"    select="concat($sio,'SIO_000240')"/>
<xsl:variable name="sio:SIO_000241"    select="concat($sio,'SIO_000241')"/>
<xsl:variable name="sio:SIO_000242"    select="concat($sio,'SIO_000242')"/>
<xsl:variable name="sio:SIO_000243"    select="concat($sio,'SIO_000243')"/>
<xsl:variable name="sio:SIO_000244"    select="concat($sio,'SIO_000244')"/>
<xsl:variable name="sio:SIO_000245"    select="concat($sio,'SIO_000245')"/>
<xsl:variable name="sio:SIO_000246"    select="concat($sio,'SIO_000246')"/>
<xsl:variable name="sio:SIO_000247"    select="concat($sio,'SIO_000247')"/>
<xsl:variable name="sio:SIO_000248"    select="concat($sio,'SIO_000248')"/>
<xsl:variable name="sio:SIO_000249"    select="concat($sio,'SIO_000249')"/>
<xsl:variable name="sio:SIO_000250"    select="concat($sio,'SIO_000250')"/>
<xsl:variable name="sio:SIO_000251"    select="concat($sio,'SIO_000251')"/>
<xsl:variable name="sio:SIO_000252"    select="concat($sio,'SIO_000252')"/>
<xsl:variable name="sio:SIO_000253"    select="concat($sio,'SIO_000253')"/>
<xsl:variable name="sio:SIO_000254"    select="concat($sio,'SIO_000254')"/>
<xsl:variable name="sio:SIO_000255"    select="concat($sio,'SIO_000255')"/>
<xsl:variable name="sio:SIO_000256"    select="concat($sio,'SIO_000256')"/>
<xsl:variable name="sio:SIO_000257"    select="concat($sio,'SIO_000257')"/>
<xsl:variable name="sio:SIO_000258"    select="concat($sio,'SIO_000258')"/>
<xsl:variable name="sio:SIO_000259"    select="concat($sio,'SIO_000259')"/>
<xsl:variable name="sio:SIO_000261"    select="concat($sio,'SIO_000261')"/>
<xsl:variable name="sio:SIO_000262"    select="concat($sio,'SIO_000262')"/>
<xsl:variable name="sio:SIO_000263"    select="concat($sio,'SIO_000263')"/>
<xsl:variable name="sio:SIO_000264"    select="concat($sio,'SIO_000264')"/>
<xsl:variable name="sio:SIO_000265"    select="concat($sio,'SIO_000265')"/>
<xsl:variable name="sio:SIO_000266"    select="concat($sio,'SIO_000266')"/>
<xsl:variable name="sio:SIO_000267"    select="concat($sio,'SIO_000267')"/>
<xsl:variable name="sio:SIO_000268"    select="concat($sio,'SIO_000268')"/>
<xsl:variable name="sio:SIO_000269"    select="concat($sio,'SIO_000269')"/>
<xsl:variable name="sio:SIO_000270"    select="concat($sio,'SIO_000270')"/>
<xsl:variable name="sio:SIO_000272"    select="concat($sio,'SIO_000272')"/>
<xsl:variable name="sio:SIO_000273"    select="concat($sio,'SIO_000273')"/>
<xsl:variable name="sio:SIO_000274"    select="concat($sio,'SIO_000274')"/>
<xsl:variable name="sio:SIO_000275"    select="concat($sio,'SIO_000275')"/>
<xsl:variable name="sio:SIO_000276"    select="concat($sio,'SIO_000276')"/>
<xsl:variable name="sio:SIO_000277"    select="concat($sio,'SIO_000277')"/>
<xsl:variable name="sio:SIO_000278"    select="concat($sio,'SIO_000278')"/>
<xsl:variable name="sio:SIO_000279"    select="concat($sio,'SIO_000279')"/>
<xsl:variable name="sio:SIO_000280"    select="concat($sio,'SIO_000280')"/>
<xsl:variable name="sio:SIO_000281"    select="concat($sio,'SIO_000281')"/>
<xsl:variable name="sio:SIO_000282"    select="concat($sio,'SIO_000282')"/>
<xsl:variable name="sio:SIO_000283"    select="concat($sio,'SIO_000283')"/>
<xsl:variable name="sio:SIO_000284"    select="concat($sio,'SIO_000284')"/>
<xsl:variable name="sio:SIO_000285"    select="concat($sio,'SIO_000285')"/>
<xsl:variable name="sio:SIO_000286"    select="concat($sio,'SIO_000286')"/>
<xsl:variable name="sio:SIO_000287"    select="concat($sio,'SIO_000287')"/>
<xsl:variable name="sio:SIO_000288"    select="concat($sio,'SIO_000288')"/>
<xsl:variable name="sio:SIO_000289"    select="concat($sio,'SIO_000289')"/>
<xsl:variable name="sio:SIO_000290"    select="concat($sio,'SIO_000290')"/>
<xsl:variable name="sio:SIO_000291"    select="concat($sio,'SIO_000291')"/>
<xsl:variable name="sio:SIO_000292"    select="concat($sio,'SIO_000292')"/>
<xsl:variable name="sio:SIO_000293"    select="concat($sio,'SIO_000293')"/>
<xsl:variable name="sio:SIO_000294"    select="concat($sio,'SIO_000294')"/>
<xsl:variable name="sio:SIO_000295"    select="concat($sio,'SIO_000295')"/>
<xsl:variable name="sio:SIO_000296"    select="concat($sio,'SIO_000296')"/>
<xsl:variable name="sio:SIO_000297"    select="concat($sio,'SIO_000297')"/>
<xsl:variable name="sio:SIO_000298"    select="concat($sio,'SIO_000298')"/>
<xsl:variable name="sio:SIO_000299"    select="concat($sio,'SIO_000299')"/>
<xsl:variable name="sio:SIO_000300"    select="concat($sio,'SIO_000300')"/>
<xsl:variable name="sio:SIO_000301"    select="concat($sio,'SIO_000301')"/>
<xsl:variable name="sio:SIO_000302"    select="concat($sio,'SIO_000302')"/>
<xsl:variable name="sio:SIO_000304"    select="concat($sio,'SIO_000304')"/>
<xsl:variable name="sio:SIO_000305"    select="concat($sio,'SIO_000305')"/>
<xsl:variable name="sio:SIO_000306"    select="concat($sio,'SIO_000306')"/>
<xsl:variable name="sio:SIO_000307"    select="concat($sio,'SIO_000307')"/>
<xsl:variable name="sio:SIO_000308"    select="concat($sio,'SIO_000308')"/>
<xsl:variable name="sio:SIO_000309"    select="concat($sio,'SIO_000309')"/>
<xsl:variable name="sio:SIO_000310"    select="concat($sio,'SIO_000310')"/>
<xsl:variable name="sio:SIO_000311"    select="concat($sio,'SIO_000311')"/>
<xsl:variable name="sio:SIO_000312"    select="concat($sio,'SIO_000312')"/>
<xsl:variable name="sio:SIO_000313"    select="concat($sio,'SIO_000313')"/>
<xsl:variable name="sio:SIO_000314"    select="concat($sio,'SIO_000314')"/>
<xsl:variable name="sio:SIO_000315"    select="concat($sio,'SIO_000315')"/>
<xsl:variable name="sio:SIO_000316"    select="concat($sio,'SIO_000316')"/>
<xsl:variable name="sio:SIO_000317"    select="concat($sio,'SIO_000317')"/>
<xsl:variable name="sio:SIO_000318"    select="concat($sio,'SIO_000318')"/>
<xsl:variable name="sio:SIO_000319"    select="concat($sio,'SIO_000319')"/>
<xsl:variable name="sio:SIO_000320"    select="concat($sio,'SIO_000320')"/>
<xsl:variable name="sio:SIO_000321"    select="concat($sio,'SIO_000321')"/>
<xsl:variable name="sio:SIO_000322"    select="concat($sio,'SIO_000322')"/>
<xsl:variable name="sio:SIO_000323"    select="concat($sio,'SIO_000323')"/>
<xsl:variable name="sio:SIO_000324"    select="concat($sio,'SIO_000324')"/>
<xsl:variable name="sio:SIO_000325"    select="concat($sio,'SIO_000325')"/>
<xsl:variable name="sio:SIO_000326"    select="concat($sio,'SIO_000326')"/>
<xsl:variable name="sio:SIO_000327"    select="concat($sio,'SIO_000327')"/>
<xsl:variable name="sio:SIO_000328"    select="concat($sio,'SIO_000328')"/>
<xsl:variable name="sio:SIO_000329"    select="concat($sio,'SIO_000329')"/>
<xsl:variable name="sio:SIO_000330"    select="concat($sio,'SIO_000330')"/>
<xsl:variable name="sio:SIO_000331"    select="concat($sio,'SIO_000331')"/>
<xsl:variable name="sio:SIO_000332"    select="concat($sio,'SIO_000332')"/>
<xsl:variable name="sio:SIO_000333"    select="concat($sio,'SIO_000333')"/>
<xsl:variable name="sio:SIO_000334"    select="concat($sio,'SIO_000334')"/>
<xsl:variable name="sio:SIO_000335"    select="concat($sio,'SIO_000335')"/>
<xsl:variable name="sio:SIO_000337"    select="concat($sio,'SIO_000337')"/>
<xsl:variable name="sio:SIO_000338"    select="concat($sio,'SIO_000338')"/>
<xsl:variable name="sio:SIO_000339"    select="concat($sio,'SIO_000339')"/>
<xsl:variable name="sio:SIO_000340"    select="concat($sio,'SIO_000340')"/>
<xsl:variable name="sio:SIO_000341"    select="concat($sio,'SIO_000341')"/>
<xsl:variable name="sio:SIO_000342"    select="concat($sio,'SIO_000342')"/>
<xsl:variable name="sio:SIO_000343"    select="concat($sio,'SIO_000343')"/>
<xsl:variable name="sio:SIO_000344"    select="concat($sio,'SIO_000344')"/>
<xsl:variable name="sio:SIO_000345"    select="concat($sio,'SIO_000345')"/>
<xsl:variable name="sio:SIO_000346"    select="concat($sio,'SIO_000346')"/>
<xsl:variable name="sio:SIO_000347"    select="concat($sio,'SIO_000347')"/>
<xsl:variable name="sio:SIO_000348"    select="concat($sio,'SIO_000348')"/>
<xsl:variable name="sio:SIO_000349"    select="concat($sio,'SIO_000349')"/>
<xsl:variable name="sio:SIO_000350"    select="concat($sio,'SIO_000350')"/>
<xsl:variable name="sio:SIO_000351"    select="concat($sio,'SIO_000351')"/>
<xsl:variable name="sio:SIO_000352"    select="concat($sio,'SIO_000352')"/>
<xsl:variable name="sio:SIO_000353"    select="concat($sio,'SIO_000353')"/>
<xsl:variable name="sio:SIO_000354"    select="concat($sio,'SIO_000354')"/>
<xsl:variable name="sio:SIO_000355"    select="concat($sio,'SIO_000355')"/>
<xsl:variable name="sio:SIO_000356"    select="concat($sio,'SIO_000356')"/>
<xsl:variable name="sio:SIO_000357"    select="concat($sio,'SIO_000357')"/>
<xsl:variable name="sio:SIO_000358"    select="concat($sio,'SIO_000358')"/>
<xsl:variable name="sio:SIO_000359"    select="concat($sio,'SIO_000359')"/>
<xsl:variable name="sio:SIO_000360"    select="concat($sio,'SIO_000360')"/>
<xsl:variable name="sio:SIO_000362"    select="concat($sio,'SIO_000362')"/>
<xsl:variable name="sio:SIO_000363"    select="concat($sio,'SIO_000363')"/>
<xsl:variable name="sio:SIO_000364"    select="concat($sio,'SIO_000364')"/>
<xsl:variable name="sio:SIO_000365"    select="concat($sio,'SIO_000365')"/>
<xsl:variable name="sio:SIO_000366"    select="concat($sio,'SIO_000366')"/>
<xsl:variable name="sio:SIO_000367"    select="concat($sio,'SIO_000367')"/>
<xsl:variable name="sio:SIO_000368"    select="concat($sio,'SIO_000368')"/>
<xsl:variable name="sio:SIO_000369"    select="concat($sio,'SIO_000369')"/>
<xsl:variable name="sio:SIO_000370"    select="concat($sio,'SIO_000370')"/>
<xsl:variable name="sio:SIO_000371"    select="concat($sio,'SIO_000371')"/>
<xsl:variable name="sio:SIO_000372"    select="concat($sio,'SIO_000372')"/>
<xsl:variable name="sio:SIO_000373"    select="concat($sio,'SIO_000373')"/>
<xsl:variable name="sio:SIO_000374"    select="concat($sio,'SIO_000374')"/>
<xsl:variable name="sio:SIO_000375"    select="concat($sio,'SIO_000375')"/>
<xsl:variable name="sio:SIO_000376"    select="concat($sio,'SIO_000376')"/>
<xsl:variable name="sio:SIO_000377"    select="concat($sio,'SIO_000377')"/>
<xsl:variable name="sio:SIO_000378"    select="concat($sio,'SIO_000378')"/>
<xsl:variable name="sio:SIO_000379"    select="concat($sio,'SIO_000379')"/>
<xsl:variable name="sio:SIO_000380"    select="concat($sio,'SIO_000380')"/>
<xsl:variable name="sio:SIO_000381"    select="concat($sio,'SIO_000381')"/>
<xsl:variable name="sio:SIO_000382"    select="concat($sio,'SIO_000382')"/>
<xsl:variable name="sio:SIO_000383"    select="concat($sio,'SIO_000383')"/>
<xsl:variable name="sio:SIO_000384"    select="concat($sio,'SIO_000384')"/>
<xsl:variable name="sio:SIO_000385"    select="concat($sio,'SIO_000385')"/>
<xsl:variable name="sio:SIO_000386"    select="concat($sio,'SIO_000386')"/>
<xsl:variable name="sio:SIO_000387"    select="concat($sio,'SIO_000387')"/>
<xsl:variable name="sio:SIO_000388"    select="concat($sio,'SIO_000388')"/>
<xsl:variable name="sio:SIO_000389"    select="concat($sio,'SIO_000389')"/>
<xsl:variable name="sio:SIO_000390"    select="concat($sio,'SIO_000390')"/>
<xsl:variable name="sio:SIO_000391"    select="concat($sio,'SIO_000391')"/>
<xsl:variable name="sio:SIO_000392"    select="concat($sio,'SIO_000392')"/>
<xsl:variable name="sio:SIO_000393"    select="concat($sio,'SIO_000393')"/>
<xsl:variable name="sio:SIO_000394"    select="concat($sio,'SIO_000394')"/>
<xsl:variable name="sio:SIO_000395"    select="concat($sio,'SIO_000395')"/>
<xsl:variable name="sio:SIO_000396"    select="concat($sio,'SIO_000396')"/>
<xsl:variable name="sio:SIO_000397"    select="concat($sio,'SIO_000397')"/>
<xsl:variable name="sio:SIO_000398"    select="concat($sio,'SIO_000398')"/>
<xsl:variable name="sio:SIO_000399"    select="concat($sio,'SIO_000399')"/>
<xsl:variable name="sio:SIO_000400"    select="concat($sio,'SIO_000400')"/>
<xsl:variable name="sio:SIO_000401"    select="concat($sio,'SIO_000401')"/>
<xsl:variable name="sio:SIO_000402"    select="concat($sio,'SIO_000402')"/>
<xsl:variable name="sio:SIO_000403"    select="concat($sio,'SIO_000403')"/>
<xsl:variable name="sio:SIO_000404"    select="concat($sio,'SIO_000404')"/>
<xsl:variable name="sio:SIO_000405"    select="concat($sio,'SIO_000405')"/>
<xsl:variable name="sio:SIO_000406"    select="concat($sio,'SIO_000406')"/>
<xsl:variable name="sio:SIO_000407"    select="concat($sio,'SIO_000407')"/>
<xsl:variable name="sio:SIO_000408"    select="concat($sio,'SIO_000408')"/>
<xsl:variable name="sio:SIO_000409"    select="concat($sio,'SIO_000409')"/>
<xsl:variable name="sio:SIO_000410"    select="concat($sio,'SIO_000410')"/>
<xsl:variable name="sio:SIO_000411"    select="concat($sio,'SIO_000411')"/>
<xsl:variable name="sio:SIO_000412"    select="concat($sio,'SIO_000412')"/>
<xsl:variable name="sio:SIO_000413"    select="concat($sio,'SIO_000413')"/>
<xsl:variable name="sio:SIO_000414"    select="concat($sio,'SIO_000414')"/>
<xsl:variable name="sio:SIO_000415"    select="concat($sio,'SIO_000415')"/>
<xsl:variable name="sio:SIO_000417"    select="concat($sio,'SIO_000417')"/>
<xsl:variable name="sio:SIO_000418"    select="concat($sio,'SIO_000418')"/>
<xsl:variable name="sio:SIO_000419"    select="concat($sio,'SIO_000419')"/>
<xsl:variable name="sio:SIO_000420"    select="concat($sio,'SIO_000420')"/>
<xsl:variable name="sio:SIO_000421"    select="concat($sio,'SIO_000421')"/>
<xsl:variable name="sio:SIO_000422"    select="concat($sio,'SIO_000422')"/>
<xsl:variable name="sio:SIO_000423"    select="concat($sio,'SIO_000423')"/>
<xsl:variable name="sio:SIO_000424"    select="concat($sio,'SIO_000424')"/>
<xsl:variable name="sio:SIO_000425"    select="concat($sio,'SIO_000425')"/>
<xsl:variable name="sio:SIO_000426"    select="concat($sio,'SIO_000426')"/>
<xsl:variable name="sio:SIO_000427"    select="concat($sio,'SIO_000427')"/>
<xsl:variable name="sio:SIO_000428"    select="concat($sio,'SIO_000428')"/>
<xsl:variable name="sio:SIO_000429"    select="concat($sio,'SIO_000429')"/>
<xsl:variable name="sio:SIO_000430"    select="concat($sio,'SIO_000430')"/>
<xsl:variable name="sio:SIO_000431"    select="concat($sio,'SIO_000431')"/>
<xsl:variable name="sio:SIO_000432"    select="concat($sio,'SIO_000432')"/>
<xsl:variable name="sio:SIO_000433"    select="concat($sio,'SIO_000433')"/>
<xsl:variable name="sio:SIO_000434"    select="concat($sio,'SIO_000434')"/>
<xsl:variable name="sio:SIO_000435"    select="concat($sio,'SIO_000435')"/>
<xsl:variable name="sio:SIO_000436"    select="concat($sio,'SIO_000436')"/>
<xsl:variable name="sio:SIO_000437"    select="concat($sio,'SIO_000437')"/>
<xsl:variable name="sio:SIO_000438"    select="concat($sio,'SIO_000438')"/>
<xsl:variable name="sio:SIO_000439"    select="concat($sio,'SIO_000439')"/>
<xsl:variable name="sio:SIO_000440"    select="concat($sio,'SIO_000440')"/>
<xsl:variable name="sio:SIO_000441"    select="concat($sio,'SIO_000441')"/>
<xsl:variable name="sio:SIO_000442"    select="concat($sio,'SIO_000442')"/>
<xsl:variable name="sio:SIO_000443"    select="concat($sio,'SIO_000443')"/>
<xsl:variable name="sio:SIO_000444"    select="concat($sio,'SIO_000444')"/>
<xsl:variable name="sio:SIO_000445"    select="concat($sio,'SIO_000445')"/>
<xsl:variable name="sio:SIO_000446"    select="concat($sio,'SIO_000446')"/>
<xsl:variable name="sio:SIO_000447"    select="concat($sio,'SIO_000447')"/>
<xsl:variable name="sio:SIO_000448"    select="concat($sio,'SIO_000448')"/>
<xsl:variable name="sio:SIO_000449"    select="concat($sio,'SIO_000449')"/>
<xsl:variable name="sio:SIO_000450"    select="concat($sio,'SIO_000450')"/>
<xsl:variable name="sio:SIO_000451"    select="concat($sio,'SIO_000451')"/>
<xsl:variable name="sio:SIO_000452"    select="concat($sio,'SIO_000452')"/>
<xsl:variable name="sio:SIO_000453"    select="concat($sio,'SIO_000453')"/>
<xsl:variable name="sio:SIO_000454"    select="concat($sio,'SIO_000454')"/>
<xsl:variable name="sio:SIO_000455"    select="concat($sio,'SIO_000455')"/>
<xsl:variable name="sio:SIO_000456"    select="concat($sio,'SIO_000456')"/>
<xsl:variable name="sio:SIO_000457"    select="concat($sio,'SIO_000457')"/>
<xsl:variable name="sio:SIO_000458"    select="concat($sio,'SIO_000458')"/>
<xsl:variable name="sio:SIO_000459"    select="concat($sio,'SIO_000459')"/>
<xsl:variable name="sio:SIO_000460"    select="concat($sio,'SIO_000460')"/>
<xsl:variable name="sio:SIO_000461"    select="concat($sio,'SIO_000461')"/>
<xsl:variable name="sio:SIO_000462"    select="concat($sio,'SIO_000462')"/>
<xsl:variable name="sio:SIO_000463"    select="concat($sio,'SIO_000463')"/>
<xsl:variable name="sio:SIO_000464"    select="concat($sio,'SIO_000464')"/>
<xsl:variable name="sio:SIO_000465"    select="concat($sio,'SIO_000465')"/>
<xsl:variable name="sio:SIO_000466"    select="concat($sio,'SIO_000466')"/>
<xsl:variable name="sio:SIO_000467"    select="concat($sio,'SIO_000467')"/>
<xsl:variable name="sio:SIO_000468"    select="concat($sio,'SIO_000468')"/>
<xsl:variable name="sio:SIO_000469"    select="concat($sio,'SIO_000469')"/>
<xsl:variable name="sio:SIO_000470"    select="concat($sio,'SIO_000470')"/>
<xsl:variable name="sio:SIO_000471"    select="concat($sio,'SIO_000471')"/>
<xsl:variable name="sio:SIO_000472"    select="concat($sio,'SIO_000472')"/>
<xsl:variable name="sio:SIO_000473"    select="concat($sio,'SIO_000473')"/>
<xsl:variable name="sio:SIO_000474"    select="concat($sio,'SIO_000474')"/>
<xsl:variable name="sio:SIO_000475"    select="concat($sio,'SIO_000475')"/>
<xsl:variable name="sio:SIO_000476"    select="concat($sio,'SIO_000476')"/>
<xsl:variable name="sio:SIO_000477"    select="concat($sio,'SIO_000477')"/>
<xsl:variable name="sio:SIO_000478"    select="concat($sio,'SIO_000478')"/>
<xsl:variable name="sio:SIO_000479"    select="concat($sio,'SIO_000479')"/>
<xsl:variable name="sio:SIO_000480"    select="concat($sio,'SIO_000480')"/>
<xsl:variable name="sio:SIO_000481"    select="concat($sio,'SIO_000481')"/>
<xsl:variable name="sio:SIO_000482"    select="concat($sio,'SIO_000482')"/>
<xsl:variable name="sio:SIO_000483"    select="concat($sio,'SIO_000483')"/>
<xsl:variable name="sio:SIO_000484"    select="concat($sio,'SIO_000484')"/>
<xsl:variable name="sio:SIO_000485"    select="concat($sio,'SIO_000485')"/>
<xsl:variable name="sio:SIO_000486"    select="concat($sio,'SIO_000486')"/>
<xsl:variable name="sio:SIO_000487"    select="concat($sio,'SIO_000487')"/>
<xsl:variable name="sio:SIO_000488"    select="concat($sio,'SIO_000488')"/>
<xsl:variable name="sio:SIO_000489"    select="concat($sio,'SIO_000489')"/>
<xsl:variable name="sio:SIO_000490"    select="concat($sio,'SIO_000490')"/>
<xsl:variable name="sio:SIO_000491"    select="concat($sio,'SIO_000491')"/>
<xsl:variable name="sio:SIO_000492"    select="concat($sio,'SIO_000492')"/>
<xsl:variable name="sio:SIO_000493"    select="concat($sio,'SIO_000493')"/>
<xsl:variable name="sio:SIO_000494"    select="concat($sio,'SIO_000494')"/>
<xsl:variable name="sio:SIO_000495"    select="concat($sio,'SIO_000495')"/>
<xsl:variable name="sio:SIO_000496"    select="concat($sio,'SIO_000496')"/>
<xsl:variable name="sio:SIO_000497"    select="concat($sio,'SIO_000497')"/>
<xsl:variable name="sio:SIO_000498"    select="concat($sio,'SIO_000498')"/>
<xsl:variable name="sio:SIO_000499"    select="concat($sio,'SIO_000499')"/>
<xsl:variable name="sio:SIO_000500"    select="concat($sio,'SIO_000500')"/>
<xsl:variable name="sio:SIO_000501"    select="concat($sio,'SIO_000501')"/>
<xsl:variable name="sio:SIO_000502"    select="concat($sio,'SIO_000502')"/>
<xsl:variable name="sio:SIO_000503"    select="concat($sio,'SIO_000503')"/>
<xsl:variable name="sio:SIO_000504"    select="concat($sio,'SIO_000504')"/>
<xsl:variable name="sio:SIO_000505"    select="concat($sio,'SIO_000505')"/>
<xsl:variable name="sio:SIO_000506"    select="concat($sio,'SIO_000506')"/>
<xsl:variable name="sio:SIO_000507"    select="concat($sio,'SIO_000507')"/>
<xsl:variable name="sio:SIO_000508"    select="concat($sio,'SIO_000508')"/>
<xsl:variable name="sio:SIO_000509"    select="concat($sio,'SIO_000509')"/>
<xsl:variable name="sio:SIO_000510"    select="concat($sio,'SIO_000510')"/>
<xsl:variable name="sio:SIO_000511"    select="concat($sio,'SIO_000511')"/>
<xsl:variable name="sio:SIO_000512"    select="concat($sio,'SIO_000512')"/>
<xsl:variable name="sio:SIO_000513"    select="concat($sio,'SIO_000513')"/>
<xsl:variable name="sio:SIO_000514"    select="concat($sio,'SIO_000514')"/>
<xsl:variable name="sio:SIO_000515"    select="concat($sio,'SIO_000515')"/>
<xsl:variable name="sio:SIO_000516"    select="concat($sio,'SIO_000516')"/>
<xsl:variable name="sio:SIO_000517"    select="concat($sio,'SIO_000517')"/>
<xsl:variable name="sio:SIO_000518"    select="concat($sio,'SIO_000518')"/>
<xsl:variable name="sio:SIO_000519"    select="concat($sio,'SIO_000519')"/>
<xsl:variable name="sio:SIO_000520"    select="concat($sio,'SIO_000520')"/>
<xsl:variable name="sio:SIO_000521"    select="concat($sio,'SIO_000521')"/>
<xsl:variable name="sio:SIO_000522"    select="concat($sio,'SIO_000522')"/>
<xsl:variable name="sio:SIO_000523"    select="concat($sio,'SIO_000523')"/>
<xsl:variable name="sio:SIO_000524"    select="concat($sio,'SIO_000524')"/>
<xsl:variable name="sio:SIO_000525"    select="concat($sio,'SIO_000525')"/>
<xsl:variable name="sio:SIO_000526"    select="concat($sio,'SIO_000526')"/>
<xsl:variable name="sio:SIO_000527"    select="concat($sio,'SIO_000527')"/>
<xsl:variable name="sio:SIO_000528"    select="concat($sio,'SIO_000528')"/>
<xsl:variable name="sio:SIO_000529"    select="concat($sio,'SIO_000529')"/>
<xsl:variable name="sio:SIO_000530"    select="concat($sio,'SIO_000530')"/>
<xsl:variable name="sio:SIO_000531"    select="concat($sio,'SIO_000531')"/>
<xsl:variable name="sio:SIO_000532"    select="concat($sio,'SIO_000532')"/>
<xsl:variable name="sio:SIO_000533"    select="concat($sio,'SIO_000533')"/>
<xsl:variable name="sio:SIO_000534"    select="concat($sio,'SIO_000534')"/>
<xsl:variable name="sio:SIO_000535"    select="concat($sio,'SIO_000535')"/>
<xsl:variable name="sio:SIO_000536"    select="concat($sio,'SIO_000536')"/>
<xsl:variable name="sio:SIO_000537"    select="concat($sio,'SIO_000537')"/>
<xsl:variable name="sio:SIO_000538"    select="concat($sio,'SIO_000538')"/>
<xsl:variable name="sio:SIO_000539"    select="concat($sio,'SIO_000539')"/>
<xsl:variable name="sio:SIO_000540"    select="concat($sio,'SIO_000540')"/>
<xsl:variable name="sio:SIO_000541"    select="concat($sio,'SIO_000541')"/>
<xsl:variable name="sio:SIO_000542"    select="concat($sio,'SIO_000542')"/>
<xsl:variable name="sio:SIO_000543"    select="concat($sio,'SIO_000543')"/>
<xsl:variable name="sio:SIO_000544"    select="concat($sio,'SIO_000544')"/>
<xsl:variable name="sio:SIO_000545"    select="concat($sio,'SIO_000545')"/>
<xsl:variable name="sio:SIO_000546"    select="concat($sio,'SIO_000546')"/>
<xsl:variable name="sio:SIO_000547"    select="concat($sio,'SIO_000547')"/>
<xsl:variable name="sio:SIO_000549"    select="concat($sio,'SIO_000549')"/>
<xsl:variable name="sio:SIO_000550"    select="concat($sio,'SIO_000550')"/>
<xsl:variable name="sio:SIO_000551"    select="concat($sio,'SIO_000551')"/>
<xsl:variable name="sio:SIO_000552"    select="concat($sio,'SIO_000552')"/>
<xsl:variable name="sio:SIO_000553"    select="concat($sio,'SIO_000553')"/>
<xsl:variable name="sio:SIO_000554"    select="concat($sio,'SIO_000554')"/>
<xsl:variable name="sio:SIO_000555"    select="concat($sio,'SIO_000555')"/>
<xsl:variable name="sio:SIO_000556"    select="concat($sio,'SIO_000556')"/>
<xsl:variable name="sio:SIO_000557"    select="concat($sio,'SIO_000557')"/>
<xsl:variable name="sio:SIO_000558"    select="concat($sio,'SIO_000558')"/>
<xsl:variable name="sio:SIO_000559"    select="concat($sio,'SIO_000559')"/>
<xsl:variable name="sio:SIO_000561"    select="concat($sio,'SIO_000561')"/>
<xsl:variable name="sio:SIO_000562"    select="concat($sio,'SIO_000562')"/>
<xsl:variable name="sio:SIO_000563"    select="concat($sio,'SIO_000563')"/>
<xsl:variable name="sio:SIO_000564"    select="concat($sio,'SIO_000564')"/>
<xsl:variable name="sio:SIO_000565"    select="concat($sio,'SIO_000565')"/>
<xsl:variable name="sio:SIO_000566"    select="concat($sio,'SIO_000566')"/>
<xsl:variable name="sio:SIO_000567"    select="concat($sio,'SIO_000567')"/>
<xsl:variable name="sio:SIO_000568"    select="concat($sio,'SIO_000568')"/>
<xsl:variable name="sio:SIO_000569"    select="concat($sio,'SIO_000569')"/>
<xsl:variable name="sio:SIO_000570"    select="concat($sio,'SIO_000570')"/>
<xsl:variable name="sio:SIO_000571"    select="concat($sio,'SIO_000571')"/>
<xsl:variable name="sio:SIO_000572"    select="concat($sio,'SIO_000572')"/>
<xsl:variable name="sio:SIO_000573"    select="concat($sio,'SIO_000573')"/>
<xsl:variable name="sio:SIO_000574"    select="concat($sio,'SIO_000574')"/>
<xsl:variable name="sio:SIO_000575"    select="concat($sio,'SIO_000575')"/>
<xsl:variable name="sio:SIO_000576"    select="concat($sio,'SIO_000576')"/>
<xsl:variable name="sio:SIO_000577"    select="concat($sio,'SIO_000577')"/>
<xsl:variable name="sio:SIO_000578"    select="concat($sio,'SIO_000578')"/>
<xsl:variable name="sio:SIO_000579"    select="concat($sio,'SIO_000579')"/>
<xsl:variable name="sio:SIO_000580"    select="concat($sio,'SIO_000580')"/>
<xsl:variable name="sio:SIO_000581"    select="concat($sio,'SIO_000581')"/>
<xsl:variable name="sio:SIO_000582"    select="concat($sio,'SIO_000582')"/>
<xsl:variable name="sio:SIO_000583"    select="concat($sio,'SIO_000583')"/>
<xsl:variable name="sio:SIO_000585"    select="concat($sio,'SIO_000585')"/>
<xsl:variable name="sio:SIO_000586"    select="concat($sio,'SIO_000586')"/>
<xsl:variable name="sio:SIO_000587"    select="concat($sio,'SIO_000587')"/>
<xsl:variable name="sio:SIO_000588"    select="concat($sio,'SIO_000588')"/>
<xsl:variable name="sio:SIO_000589"    select="concat($sio,'SIO_000589')"/>
<xsl:variable name="sio:SIO_000590"    select="concat($sio,'SIO_000590')"/>
<xsl:variable name="sio:SIO_000591"    select="concat($sio,'SIO_000591')"/>
<xsl:variable name="sio:SIO_000592"    select="concat($sio,'SIO_000592')"/>
<xsl:variable name="sio:SIO_000593"    select="concat($sio,'SIO_000593')"/>
<xsl:variable name="sio:SIO_000594"    select="concat($sio,'SIO_000594')"/>
<xsl:variable name="sio:SIO_000595"    select="concat($sio,'SIO_000595')"/>
<xsl:variable name="sio:SIO_000596"    select="concat($sio,'SIO_000596')"/>
<xsl:variable name="sio:SIO_000597"    select="concat($sio,'SIO_000597')"/>
<xsl:variable name="sio:SIO_000598"    select="concat($sio,'SIO_000598')"/>
<xsl:variable name="sio:SIO_000600"    select="concat($sio,'SIO_000600')"/>
<xsl:variable name="sio:SIO_000602"    select="concat($sio,'SIO_000602')"/>
<xsl:variable name="sio:SIO_000605"    select="concat($sio,'SIO_000605')"/>
<xsl:variable name="sio:SIO_000608"    select="concat($sio,'SIO_000608')"/>
<xsl:variable name="sio:SIO_000609"    select="concat($sio,'SIO_000609')"/>
<xsl:variable name="sio:SIO_000610"    select="concat($sio,'SIO_000610')"/>
<xsl:variable name="sio:SIO_000611"    select="concat($sio,'SIO_000611')"/>
<xsl:variable name="sio:SIO_000612"    select="concat($sio,'SIO_000612')"/>
<xsl:variable name="sio:SIO_000613"    select="concat($sio,'SIO_000613')"/>
<xsl:variable name="sio:SIO_000614"    select="concat($sio,'SIO_000614')"/>
<xsl:variable name="sio:SIO_000616"    select="concat($sio,'SIO_000616')"/>
<xsl:variable name="sio:SIO_000617"    select="concat($sio,'SIO_000617')"/>
<xsl:variable name="sio:SIO_000618"    select="concat($sio,'SIO_000618')"/>
<xsl:variable name="sio:SIO_000619"    select="concat($sio,'SIO_000619')"/>
<xsl:variable name="sio:SIO_000620"    select="concat($sio,'SIO_000620')"/>
<xsl:variable name="sio:SIO_000621"    select="concat($sio,'SIO_000621')"/>
<xsl:variable name="sio:SIO_000622"    select="concat($sio,'SIO_000622')"/>
<xsl:variable name="sio:SIO_000623"    select="concat($sio,'SIO_000623')"/>
<xsl:variable name="sio:SIO_000624"    select="concat($sio,'SIO_000624')"/>
<xsl:variable name="sio:SIO_000625"    select="concat($sio,'SIO_000625')"/>
<xsl:variable name="sio:SIO_000626"    select="concat($sio,'SIO_000626')"/>
<xsl:variable name="sio:SIO_000628"    select="concat($sio,'SIO_000628')"/>
<xsl:variable name="sio:SIO_000629"    select="concat($sio,'SIO_000629')"/>
<xsl:variable name="sio:SIO_000630"    select="concat($sio,'SIO_000630')"/>
<xsl:variable name="sio:SIO_000631"    select="concat($sio,'SIO_000631')"/>
<xsl:variable name="sio:SIO_000632"    select="concat($sio,'SIO_000632')"/>
<xsl:variable name="sio:SIO_000633"    select="concat($sio,'SIO_000633')"/>
<xsl:variable name="sio:SIO_000634"    select="concat($sio,'SIO_000634')"/>
<xsl:variable name="sio:SIO_000635"    select="concat($sio,'SIO_000635')"/>
<xsl:variable name="sio:SIO_000636"    select="concat($sio,'SIO_000636')"/>
<xsl:variable name="sio:SIO_000638"    select="concat($sio,'SIO_000638')"/>
<xsl:variable name="sio:SIO_000639"    select="concat($sio,'SIO_000639')"/>
<xsl:variable name="sio:SIO_000640"    select="concat($sio,'SIO_000640')"/>
<xsl:variable name="sio:SIO_000641"    select="concat($sio,'SIO_000641')"/>
<xsl:variable name="sio:SIO_000642"    select="concat($sio,'SIO_000642')"/>
<xsl:variable name="sio:SIO_000643"    select="concat($sio,'SIO_000643')"/>
<xsl:variable name="sio:SIO_000644"    select="concat($sio,'SIO_000644')"/>
<xsl:variable name="sio:SIO_000646"    select="concat($sio,'SIO_000646')"/>
<xsl:variable name="sio:SIO_000647"    select="concat($sio,'SIO_000647')"/>
<xsl:variable name="sio:SIO_000648"    select="concat($sio,'SIO_000648')"/>
<xsl:variable name="sio:SIO_000649"    select="concat($sio,'SIO_000649')"/>
<xsl:variable name="sio:SIO_000650"    select="concat($sio,'SIO_000650')"/>
<xsl:variable name="sio:SIO_000651"    select="concat($sio,'SIO_000651')"/>
<xsl:variable name="sio:SIO_000652"    select="concat($sio,'SIO_000652')"/>
<xsl:variable name="sio:SIO_000653"    select="concat($sio,'SIO_000653')"/>
<xsl:variable name="sio:SIO_000654"    select="concat($sio,'SIO_000654')"/>
<xsl:variable name="sio:SIO_000655"    select="concat($sio,'SIO_000655')"/>
<xsl:variable name="sio:SIO_000656"    select="concat($sio,'SIO_000656')"/>
<xsl:variable name="sio:SIO_000657"    select="concat($sio,'SIO_000657')"/>
<xsl:variable name="sio:SIO_000658"    select="concat($sio,'SIO_000658')"/>
<xsl:variable name="sio:SIO_000660"    select="concat($sio,'SIO_000660')"/>
<xsl:variable name="sio:SIO_000661"    select="concat($sio,'SIO_000661')"/>
<xsl:variable name="sio:SIO_000662"    select="concat($sio,'SIO_000662')"/>
<xsl:variable name="sio:SIO_000663"    select="concat($sio,'SIO_000663')"/>
<xsl:variable name="sio:SIO_000664"    select="concat($sio,'SIO_000664')"/>
<xsl:variable name="sio:SIO_000665"    select="concat($sio,'SIO_000665')"/>
<xsl:variable name="sio:SIO_000666"    select="concat($sio,'SIO_000666')"/>
<xsl:variable name="sio:SIO_000667"    select="concat($sio,'SIO_000667')"/>
<xsl:variable name="sio:SIO_000668"    select="concat($sio,'SIO_000668')"/>
<xsl:variable name="sio:SIO_000669"    select="concat($sio,'SIO_000669')"/>
<xsl:variable name="sio:SIO_000670"    select="concat($sio,'SIO_000670')"/>
<xsl:variable name="sio:SIO_000671"    select="concat($sio,'SIO_000671')"/>
<xsl:variable name="sio:SIO_000672"    select="concat($sio,'SIO_000672')"/>
<xsl:variable name="sio:SIO_000673"    select="concat($sio,'SIO_000673')"/>
<xsl:variable name="sio:SIO_000674"    select="concat($sio,'SIO_000674')"/>
<xsl:variable name="sio:SIO_000675"    select="concat($sio,'SIO_000675')"/>
<xsl:variable name="sio:SIO_000676"    select="concat($sio,'SIO_000676')"/>
<xsl:variable name="sio:SIO_000677"    select="concat($sio,'SIO_000677')"/>
<xsl:variable name="sio:SIO_000678"    select="concat($sio,'SIO_000678')"/>
<xsl:variable name="sio:SIO_000679"    select="concat($sio,'SIO_000679')"/>
<xsl:variable name="sio:SIO_000680"    select="concat($sio,'SIO_000680')"/>
<xsl:variable name="sio:SIO_000681"    select="concat($sio,'SIO_000681')"/>
<xsl:variable name="sio:SIO_000682"    select="concat($sio,'SIO_000682')"/>
<xsl:variable name="sio:SIO_000683"    select="concat($sio,'SIO_000683')"/>
<xsl:variable name="sio:SIO_000684"    select="concat($sio,'SIO_000684')"/>
<xsl:variable name="sio:SIO_000686"    select="concat($sio,'SIO_000686')"/>
<xsl:variable name="sio:SIO_000687"    select="concat($sio,'SIO_000687')"/>
<xsl:variable name="sio:SIO_000688"    select="concat($sio,'SIO_000688')"/>
<xsl:variable name="sio:SIO_000689"    select="concat($sio,'SIO_000689')"/>
<xsl:variable name="sio:SIO_000690"    select="concat($sio,'SIO_000690')"/>
<xsl:variable name="sio:SIO_000692"    select="concat($sio,'SIO_000692')"/>
<xsl:variable name="sio:SIO_000693"    select="concat($sio,'SIO_000693')"/>
<xsl:variable name="sio:SIO_000694"    select="concat($sio,'SIO_000694')"/>
<xsl:variable name="sio:SIO_000695"    select="concat($sio,'SIO_000695')"/>
<xsl:variable name="sio:SIO_000696"    select="concat($sio,'SIO_000696')"/>
<xsl:variable name="sio:SIO_000697"    select="concat($sio,'SIO_000697')"/>
<xsl:variable name="sio:SIO_000698"    select="concat($sio,'SIO_000698')"/>
<xsl:variable name="sio:SIO_000699"    select="concat($sio,'SIO_000699')"/>
<xsl:variable name="sio:SIO_000700"    select="concat($sio,'SIO_000700')"/>
<xsl:variable name="sio:SIO_000701"    select="concat($sio,'SIO_000701')"/>
<xsl:variable name="sio:SIO_000702"    select="concat($sio,'SIO_000702')"/>
<xsl:variable name="sio:SIO_000703"    select="concat($sio,'SIO_000703')"/>
<xsl:variable name="sio:SIO_000704"    select="concat($sio,'SIO_000704')"/>
<xsl:variable name="sio:SIO_000705"    select="concat($sio,'SIO_000705')"/>
<xsl:variable name="sio:SIO_000706"    select="concat($sio,'SIO_000706')"/>
<xsl:variable name="sio:SIO_000707"    select="concat($sio,'SIO_000707')"/>
<xsl:variable name="sio:SIO_000708"    select="concat($sio,'SIO_000708')"/>
<xsl:variable name="sio:SIO_000709"    select="concat($sio,'SIO_000709')"/>
<xsl:variable name="sio:SIO_000710"    select="concat($sio,'SIO_000710')"/>
<xsl:variable name="sio:SIO_000711"    select="concat($sio,'SIO_000711')"/>
<xsl:variable name="sio:SIO_000712"    select="concat($sio,'SIO_000712')"/>
<xsl:variable name="sio:SIO_000713"    select="concat($sio,'SIO_000713')"/>
<xsl:variable name="sio:SIO_000714"    select="concat($sio,'SIO_000714')"/>
<xsl:variable name="sio:SIO_000715"    select="concat($sio,'SIO_000715')"/>
<xsl:variable name="sio:SIO_000716"    select="concat($sio,'SIO_000716')"/>
<xsl:variable name="sio:SIO_000717"    select="concat($sio,'SIO_000717')"/>
<xsl:variable name="sio:SIO_000719"    select="concat($sio,'SIO_000719')"/>
<xsl:variable name="sio:SIO_000720"    select="concat($sio,'SIO_000720')"/>
<xsl:variable name="sio:SIO_000721"    select="concat($sio,'SIO_000721')"/>
<xsl:variable name="sio:SIO_000722"    select="concat($sio,'SIO_000722')"/>
<xsl:variable name="sio:SIO_000723"    select="concat($sio,'SIO_000723')"/>
<xsl:variable name="sio:SIO_000724"    select="concat($sio,'SIO_000724')"/>
<xsl:variable name="sio:SIO_000725"    select="concat($sio,'SIO_000725')"/>
<xsl:variable name="sio:SIO_000726"    select="concat($sio,'SIO_000726')"/>
<xsl:variable name="sio:SIO_000727"    select="concat($sio,'SIO_000727')"/>
<xsl:variable name="sio:SIO_000728"    select="concat($sio,'SIO_000728')"/>
<xsl:variable name="sio:SIO_000729"    select="concat($sio,'SIO_000729')"/>
<xsl:variable name="sio:SIO_000730"    select="concat($sio,'SIO_000730')"/>
<xsl:variable name="sio:SIO_000731"    select="concat($sio,'SIO_000731')"/>
<xsl:variable name="sio:SIO_000732"    select="concat($sio,'SIO_000732')"/>
<xsl:variable name="sio:SIO_000733"    select="concat($sio,'SIO_000733')"/>
<xsl:variable name="sio:SIO_000734"    select="concat($sio,'SIO_000734')"/>
<xsl:variable name="sio:SIO_000735"    select="concat($sio,'SIO_000735')"/>
<xsl:variable name="sio:SIO_000736"    select="concat($sio,'SIO_000736')"/>
<xsl:variable name="sio:SIO_000737"    select="concat($sio,'SIO_000737')"/>
<xsl:variable name="sio:SIO_000738"    select="concat($sio,'SIO_000738')"/>
<xsl:variable name="sio:SIO_000739"    select="concat($sio,'SIO_000739')"/>
<xsl:variable name="sio:SIO_000740"    select="concat($sio,'SIO_000740')"/>
<xsl:variable name="sio:SIO_000741"    select="concat($sio,'SIO_000741')"/>
<xsl:variable name="sio:SIO_000742"    select="concat($sio,'SIO_000742')"/>
<xsl:variable name="sio:SIO_000743"    select="concat($sio,'SIO_000743')"/>
<xsl:variable name="sio:SIO_000744"    select="concat($sio,'SIO_000744')"/>
<xsl:variable name="sio:SIO_000745"    select="concat($sio,'SIO_000745')"/>
<xsl:variable name="sio:SIO_000746"    select="concat($sio,'SIO_000746')"/>
<xsl:variable name="sio:SIO_000747"    select="concat($sio,'SIO_000747')"/>
<xsl:variable name="sio:SIO_000748"    select="concat($sio,'SIO_000748')"/>
<xsl:variable name="sio:SIO_000749"    select="concat($sio,'SIO_000749')"/>
<xsl:variable name="sio:SIO_000750"    select="concat($sio,'SIO_000750')"/>
<xsl:variable name="sio:SIO_000751"    select="concat($sio,'SIO_000751')"/>
<xsl:variable name="sio:SIO_000752"    select="concat($sio,'SIO_000752')"/>
<xsl:variable name="sio:SIO_000753"    select="concat($sio,'SIO_000753')"/>
<xsl:variable name="sio:SIO_000754"    select="concat($sio,'SIO_000754')"/>
<xsl:variable name="sio:SIO_000755"    select="concat($sio,'SIO_000755')"/>
<xsl:variable name="sio:SIO_000756"    select="concat($sio,'SIO_000756')"/>
<xsl:variable name="sio:SIO_000757"    select="concat($sio,'SIO_000757')"/>
<xsl:variable name="sio:SIO_000758"    select="concat($sio,'SIO_000758')"/>
<xsl:variable name="sio:SIO_000759"    select="concat($sio,'SIO_000759')"/>
<xsl:variable name="sio:SIO_000760"    select="concat($sio,'SIO_000760')"/>
<xsl:variable name="sio:SIO_000761"    select="concat($sio,'SIO_000761')"/>
<xsl:variable name="sio:SIO_000762"    select="concat($sio,'SIO_000762')"/>
<xsl:variable name="sio:SIO_000763"    select="concat($sio,'SIO_000763')"/>
<xsl:variable name="sio:SIO_000764"    select="concat($sio,'SIO_000764')"/>
<xsl:variable name="sio:SIO_000765"    select="concat($sio,'SIO_000765')"/>
<xsl:variable name="sio:SIO_000766"    select="concat($sio,'SIO_000766')"/>
<xsl:variable name="sio:SIO_000767"    select="concat($sio,'SIO_000767')"/>
<xsl:variable name="sio:SIO_000768"    select="concat($sio,'SIO_000768')"/>
<xsl:variable name="sio:SIO_000769"    select="concat($sio,'SIO_000769')"/>
<xsl:variable name="sio:SIO_000770"    select="concat($sio,'SIO_000770')"/>
<xsl:variable name="sio:SIO_000771"    select="concat($sio,'SIO_000771')"/>
<xsl:variable name="sio:SIO_000772"    select="concat($sio,'SIO_000772')"/>
<xsl:variable name="sio:SIO_000773"    select="concat($sio,'SIO_000773')"/>
<xsl:variable name="sio:SIO_000774"    select="concat($sio,'SIO_000774')"/>
<xsl:variable name="sio:SIO_000775"    select="concat($sio,'SIO_000775')"/>
<xsl:variable name="sio:SIO_000776"    select="concat($sio,'SIO_000776')"/>
<xsl:variable name="sio:SIO_000777"    select="concat($sio,'SIO_000777')"/>
<xsl:variable name="sio:SIO_000778"    select="concat($sio,'SIO_000778')"/>
<xsl:variable name="sio:SIO_000779"    select="concat($sio,'SIO_000779')"/>
<xsl:variable name="sio:SIO_000780"    select="concat($sio,'SIO_000780')"/>
<xsl:variable name="sio:SIO_000783"    select="concat($sio,'SIO_000783')"/>
<xsl:variable name="sio:SIO_000784"    select="concat($sio,'SIO_000784')"/>
<xsl:variable name="sio:SIO_000785"    select="concat($sio,'SIO_000785')"/>
<xsl:variable name="sio:SIO_000786"    select="concat($sio,'SIO_000786')"/>
<xsl:variable name="sio:SIO_000787"    select="concat($sio,'SIO_000787')"/>
<xsl:variable name="sio:SIO_000788"    select="concat($sio,'SIO_000788')"/>
<xsl:variable name="sio:SIO_000789"    select="concat($sio,'SIO_000789')"/>
<xsl:variable name="sio:SIO_000790"    select="concat($sio,'SIO_000790')"/>
<xsl:variable name="sio:SIO_000791"    select="concat($sio,'SIO_000791')"/>
<xsl:variable name="sio:SIO_000792"    select="concat($sio,'SIO_000792')"/>
<xsl:variable name="sio:SIO_000793"    select="concat($sio,'SIO_000793')"/>
<xsl:variable name="sio:SIO_000794"    select="concat($sio,'SIO_000794')"/>
<xsl:variable name="sio:SIO_000795"    select="concat($sio,'SIO_000795')"/>
<xsl:variable name="sio:SIO_000796"    select="concat($sio,'SIO_000796')"/>
<xsl:variable name="sio:SIO_000797"    select="concat($sio,'SIO_000797')"/>
<xsl:variable name="sio:SIO_000798"    select="concat($sio,'SIO_000798')"/>
<xsl:variable name="sio:SIO_000799"    select="concat($sio,'SIO_000799')"/>
<xsl:variable name="sio:SIO_000800"    select="concat($sio,'SIO_000800')"/>
<xsl:variable name="sio:SIO_000801"    select="concat($sio,'SIO_000801')"/>
<xsl:variable name="sio:SIO_000802"    select="concat($sio,'SIO_000802')"/>
<xsl:variable name="sio:SIO_000803"    select="concat($sio,'SIO_000803')"/>
<xsl:variable name="sio:SIO_000804"    select="concat($sio,'SIO_000804')"/>
<xsl:variable name="sio:SIO_000805"    select="concat($sio,'SIO_000805')"/>
<xsl:variable name="sio:SIO_000806"    select="concat($sio,'SIO_000806')"/>
<xsl:variable name="sio:SIO_000807"    select="concat($sio,'SIO_000807')"/>
<xsl:variable name="sio:SIO_000808"    select="concat($sio,'SIO_000808')"/>
<xsl:variable name="sio:SIO_000809"    select="concat($sio,'SIO_000809')"/>
<xsl:variable name="sio:SIO_000810"    select="concat($sio,'SIO_000810')"/>
<xsl:variable name="sio:SIO_000811"    select="concat($sio,'SIO_000811')"/>
<xsl:variable name="sio:SIO_000812"    select="concat($sio,'SIO_000812')"/>
<xsl:variable name="sio:SIO_000813"    select="concat($sio,'SIO_000813')"/>
<xsl:variable name="sio:SIO_000814"    select="concat($sio,'SIO_000814')"/>
<xsl:variable name="sio:SIO_000815"    select="concat($sio,'SIO_000815')"/>
<xsl:variable name="sio:SIO_000816"    select="concat($sio,'SIO_000816')"/>
<xsl:variable name="sio:SIO_000817"    select="concat($sio,'SIO_000817')"/>
<xsl:variable name="sio:SIO_000818"    select="concat($sio,'SIO_000818')"/>
<xsl:variable name="sio:SIO_000819"    select="concat($sio,'SIO_000819')"/>
<xsl:variable name="sio:SIO_000820"    select="concat($sio,'SIO_000820')"/>
<xsl:variable name="sio:SIO_000821"    select="concat($sio,'SIO_000821')"/>
<xsl:variable name="sio:SIO_000822"    select="concat($sio,'SIO_000822')"/>
<xsl:variable name="sio:SIO_000823"    select="concat($sio,'SIO_000823')"/>
<xsl:variable name="sio:SIO_000824"    select="concat($sio,'SIO_000824')"/>
<xsl:variable name="sio:SIO_000825"    select="concat($sio,'SIO_000825')"/>
<xsl:variable name="sio:SIO_000826"    select="concat($sio,'SIO_000826')"/>
<xsl:variable name="sio:SIO_000827"    select="concat($sio,'SIO_000827')"/>
<xsl:variable name="sio:SIO_000828"    select="concat($sio,'SIO_000828')"/>
<xsl:variable name="sio:SIO_000829"    select="concat($sio,'SIO_000829')"/>
<xsl:variable name="sio:SIO_000830"    select="concat($sio,'SIO_000830')"/>
<xsl:variable name="sio:SIO_000831"    select="concat($sio,'SIO_000831')"/>
<xsl:variable name="sio:SIO_000832"    select="concat($sio,'SIO_000832')"/>
<xsl:variable name="sio:SIO_000833"    select="concat($sio,'SIO_000833')"/>
<xsl:variable name="sio:SIO_000834"    select="concat($sio,'SIO_000834')"/>
<xsl:variable name="sio:SIO_000835"    select="concat($sio,'SIO_000835')"/>
<xsl:variable name="sio:SIO_000836"    select="concat($sio,'SIO_000836')"/>
<xsl:variable name="sio:SIO_000837"    select="concat($sio,'SIO_000837')"/>
<xsl:variable name="sio:SIO_000838"    select="concat($sio,'SIO_000838')"/>
<xsl:variable name="sio:SIO_000839"    select="concat($sio,'SIO_000839')"/>
<xsl:variable name="sio:SIO_000840"    select="concat($sio,'SIO_000840')"/>
<xsl:variable name="sio:SIO_000841"    select="concat($sio,'SIO_000841')"/>
<xsl:variable name="sio:SIO_000842"    select="concat($sio,'SIO_000842')"/>
<xsl:variable name="sio:SIO_000843"    select="concat($sio,'SIO_000843')"/>
<xsl:variable name="sio:SIO_000844"    select="concat($sio,'SIO_000844')"/>
<xsl:variable name="sio:SIO_000845"    select="concat($sio,'SIO_000845')"/>
<xsl:variable name="sio:SIO_000846"    select="concat($sio,'SIO_000846')"/>
<xsl:variable name="sio:SIO_000847"    select="concat($sio,'SIO_000847')"/>
<xsl:variable name="sio:SIO_000848"    select="concat($sio,'SIO_000848')"/>
<xsl:variable name="sio:SIO_000849"    select="concat($sio,'SIO_000849')"/>
<xsl:variable name="sio:SIO_000850"    select="concat($sio,'SIO_000850')"/>
<xsl:variable name="sio:SIO_000851"    select="concat($sio,'SIO_000851')"/>
<xsl:variable name="sio:SIO_000852"    select="concat($sio,'SIO_000852')"/>
<xsl:variable name="sio:SIO_000853"    select="concat($sio,'SIO_000853')"/>
<xsl:variable name="sio:SIO_000854"    select="concat($sio,'SIO_000854')"/>
<xsl:variable name="sio:SIO_000855"    select="concat($sio,'SIO_000855')"/>
<xsl:variable name="sio:SIO_000856"    select="concat($sio,'SIO_000856')"/>
<xsl:variable name="sio:SIO_000857"    select="concat($sio,'SIO_000857')"/>
<xsl:variable name="sio:SIO_000858"    select="concat($sio,'SIO_000858')"/>
<xsl:variable name="sio:SIO_000859"    select="concat($sio,'SIO_000859')"/>
<xsl:variable name="sio:SIO_000860"    select="concat($sio,'SIO_000860')"/>
<xsl:variable name="sio:SIO_000861"    select="concat($sio,'SIO_000861')"/>
<xsl:variable name="sio:SIO_000862"    select="concat($sio,'SIO_000862')"/>
<xsl:variable name="sio:SIO_000863"    select="concat($sio,'SIO_000863')"/>
<xsl:variable name="sio:SIO_000864"    select="concat($sio,'SIO_000864')"/>
<xsl:variable name="sio:SIO_000865"    select="concat($sio,'SIO_000865')"/>
<xsl:variable name="sio:SIO_000866"    select="concat($sio,'SIO_000866')"/>
<xsl:variable name="sio:SIO_000867"    select="concat($sio,'SIO_000867')"/>
<xsl:variable name="sio:SIO_000868"    select="concat($sio,'SIO_000868')"/>
<xsl:variable name="sio:SIO_000869"    select="concat($sio,'SIO_000869')"/>
<xsl:variable name="sio:SIO_000870"    select="concat($sio,'SIO_000870')"/>
<xsl:variable name="sio:SIO_000871"    select="concat($sio,'SIO_000871')"/>
<xsl:variable name="sio:SIO_000872"    select="concat($sio,'SIO_000872')"/>
<xsl:variable name="sio:SIO_000873"    select="concat($sio,'SIO_000873')"/>
<xsl:variable name="sio:SIO_000875"    select="concat($sio,'SIO_000875')"/>
<xsl:variable name="sio:SIO_000876"    select="concat($sio,'SIO_000876')"/>
<xsl:variable name="sio:SIO_000877"    select="concat($sio,'SIO_000877')"/>
<xsl:variable name="sio:SIO_000878"    select="concat($sio,'SIO_000878')"/>
<xsl:variable name="sio:SIO_000879"    select="concat($sio,'SIO_000879')"/>
<xsl:variable name="sio:SIO_000880"    select="concat($sio,'SIO_000880')"/>
<xsl:variable name="sio:SIO_000881"    select="concat($sio,'SIO_000881')"/>
<xsl:variable name="sio:SIO_000882"    select="concat($sio,'SIO_000882')"/>
<xsl:variable name="sio:SIO_000883"    select="concat($sio,'SIO_000883')"/>
<xsl:variable name="sio:SIO_000884"    select="concat($sio,'SIO_000884')"/>
<xsl:variable name="sio:SIO_000885"    select="concat($sio,'SIO_000885')"/>
<xsl:variable name="sio:SIO_000886"    select="concat($sio,'SIO_000886')"/>
<xsl:variable name="sio:SIO_000887"    select="concat($sio,'SIO_000887')"/>
<xsl:variable name="sio:SIO_000888"    select="concat($sio,'SIO_000888')"/>
<xsl:variable name="sio:SIO_000889"    select="concat($sio,'SIO_000889')"/>
<xsl:variable name="sio:SIO_000890"    select="concat($sio,'SIO_000890')"/>
<xsl:variable name="sio:SIO_000891"    select="concat($sio,'SIO_000891')"/>
<xsl:variable name="sio:SIO_000892"    select="concat($sio,'SIO_000892')"/>
<xsl:variable name="sio:SIO_000893"    select="concat($sio,'SIO_000893')"/>
<xsl:variable name="sio:SIO_000894"    select="concat($sio,'SIO_000894')"/>
<xsl:variable name="sio:SIO_000895"    select="concat($sio,'SIO_000895')"/>
<xsl:variable name="sio:SIO_000896"    select="concat($sio,'SIO_000896')"/>
<xsl:variable name="sio:SIO_000897"    select="concat($sio,'SIO_000897')"/>
<xsl:variable name="sio:SIO_000898"    select="concat($sio,'SIO_000898')"/>
<xsl:variable name="sio:SIO_000899"    select="concat($sio,'SIO_000899')"/>
<xsl:variable name="sio:SIO_000900"    select="concat($sio,'SIO_000900')"/>
<xsl:variable name="sio:SIO_000901"    select="concat($sio,'SIO_000901')"/>
<xsl:variable name="sio:SIO_000902"    select="concat($sio,'SIO_000902')"/>
<xsl:variable name="sio:SIO_000903"    select="concat($sio,'SIO_000903')"/>
<xsl:variable name="sio:SIO_000904"    select="concat($sio,'SIO_000904')"/>
<xsl:variable name="sio:SIO_000905"    select="concat($sio,'SIO_000905')"/>
<xsl:variable name="sio:SIO_000906"    select="concat($sio,'SIO_000906')"/>
<xsl:variable name="sio:SIO_000907"    select="concat($sio,'SIO_000907')"/>
<xsl:variable name="sio:SIO_000908"    select="concat($sio,'SIO_000908')"/>
<xsl:variable name="sio:SIO_000909"    select="concat($sio,'SIO_000909')"/>
<xsl:variable name="sio:SIO_000910"    select="concat($sio,'SIO_000910')"/>
<xsl:variable name="sio:SIO_000911"    select="concat($sio,'SIO_000911')"/>
<xsl:variable name="sio:SIO_000912"    select="concat($sio,'SIO_000912')"/>
<xsl:variable name="sio:SIO_000913"    select="concat($sio,'SIO_000913')"/>
<xsl:variable name="sio:SIO_000914"    select="concat($sio,'SIO_000914')"/>
<xsl:variable name="sio:SIO_000915"    select="concat($sio,'SIO_000915')"/>
<xsl:variable name="sio:SIO_000916"    select="concat($sio,'SIO_000916')"/>
<xsl:variable name="sio:SIO_000917"    select="concat($sio,'SIO_000917')"/>
<xsl:variable name="sio:SIO_000918"    select="concat($sio,'SIO_000918')"/>
<xsl:variable name="sio:SIO_000919"    select="concat($sio,'SIO_000919')"/>
<xsl:variable name="sio:SIO_000920"    select="concat($sio,'SIO_000920')"/>
<xsl:variable name="sio:SIO_000921"    select="concat($sio,'SIO_000921')"/>
<xsl:variable name="sio:SIO_000922"    select="concat($sio,'SIO_000922')"/>
<xsl:variable name="sio:SIO_000923"    select="concat($sio,'SIO_000923')"/>
<xsl:variable name="sio:SIO_000924"    select="concat($sio,'SIO_000924')"/>
<xsl:variable name="sio:SIO_000926"    select="concat($sio,'SIO_000926')"/>
<xsl:variable name="sio:SIO_000927"    select="concat($sio,'SIO_000927')"/>
<xsl:variable name="sio:SIO_000928"    select="concat($sio,'SIO_000928')"/>
<xsl:variable name="sio:SIO_000929"    select="concat($sio,'SIO_000929')"/>
<xsl:variable name="sio:SIO_000930"    select="concat($sio,'SIO_000930')"/>
<xsl:variable name="sio:SIO_000931"    select="concat($sio,'SIO_000931')"/>
<xsl:variable name="sio:SIO_000932"    select="concat($sio,'SIO_000932')"/>
<xsl:variable name="sio:SIO_000933"    select="concat($sio,'SIO_000933')"/>
<xsl:variable name="sio:SIO_000934"    select="concat($sio,'SIO_000934')"/>
<xsl:variable name="sio:SIO_000935"    select="concat($sio,'SIO_000935')"/>
<xsl:variable name="sio:SIO_000936"    select="concat($sio,'SIO_000936')"/>
<xsl:variable name="sio:SIO_000937"    select="concat($sio,'SIO_000937')"/>
<xsl:variable name="sio:SIO_000938"    select="concat($sio,'SIO_000938')"/>
<xsl:variable name="sio:SIO_000939"    select="concat($sio,'SIO_000939')"/>
<xsl:variable name="sio:SIO_000940"    select="concat($sio,'SIO_000940')"/>
<xsl:variable name="sio:SIO_000941"    select="concat($sio,'SIO_000941')"/>
<xsl:variable name="sio:SIO_000942"    select="concat($sio,'SIO_000942')"/>
<xsl:variable name="sio:SIO_000943"    select="concat($sio,'SIO_000943')"/>
<xsl:variable name="sio:SIO_000944"    select="concat($sio,'SIO_000944')"/>
<xsl:variable name="sio:SIO_000945"    select="concat($sio,'SIO_000945')"/>
<xsl:variable name="sio:SIO_000946"    select="concat($sio,'SIO_000946')"/>
<xsl:variable name="sio:SIO_000947"    select="concat($sio,'SIO_000947')"/>
<xsl:variable name="sio:SIO_000948"    select="concat($sio,'SIO_000948')"/>
<xsl:variable name="sio:SIO_000949"    select="concat($sio,'SIO_000949')"/>
<xsl:variable name="sio:SIO_000950"    select="concat($sio,'SIO_000950')"/>
<xsl:variable name="sio:SIO_000951"    select="concat($sio,'SIO_000951')"/>
<xsl:variable name="sio:SIO_000952"    select="concat($sio,'SIO_000952')"/>
<xsl:variable name="sio:SIO_000953"    select="concat($sio,'SIO_000953')"/>
<xsl:variable name="sio:SIO_000954"    select="concat($sio,'SIO_000954')"/>
<xsl:variable name="sio:SIO_000955"    select="concat($sio,'SIO_000955')"/>
<xsl:variable name="sio:SIO_000956"    select="concat($sio,'SIO_000956')"/>
<xsl:variable name="sio:SIO_000957"    select="concat($sio,'SIO_000957')"/>
<xsl:variable name="sio:SIO_000959"    select="concat($sio,'SIO_000959')"/>
<xsl:variable name="sio:SIO_000960"    select="concat($sio,'SIO_000960')"/>
<xsl:variable name="sio:SIO_000961"    select="concat($sio,'SIO_000961')"/>
<xsl:variable name="sio:SIO_000962"    select="concat($sio,'SIO_000962')"/>
<xsl:variable name="sio:SIO_000963"    select="concat($sio,'SIO_000963')"/>
<xsl:variable name="sio:SIO_000964"    select="concat($sio,'SIO_000964')"/>
<xsl:variable name="sio:SIO_000965"    select="concat($sio,'SIO_000965')"/>
<xsl:variable name="sio:SIO_000966"    select="concat($sio,'SIO_000966')"/>
<xsl:variable name="sio:SIO_000967"    select="concat($sio,'SIO_000967')"/>
<xsl:variable name="sio:SIO_000968"    select="concat($sio,'SIO_000968')"/>
<xsl:variable name="sio:SIO_000969"    select="concat($sio,'SIO_000969')"/>
<xsl:variable name="sio:SIO_000970"    select="concat($sio,'SIO_000970')"/>
<xsl:variable name="sio:SIO_000971"    select="concat($sio,'SIO_000971')"/>
<xsl:variable name="sio:SIO_000972"    select="concat($sio,'SIO_000972')"/>
<xsl:variable name="sio:SIO_000973"    select="concat($sio,'SIO_000973')"/>
<xsl:variable name="sio:SIO_000974"    select="concat($sio,'SIO_000974')"/>
<xsl:variable name="sio:SIO_000975"    select="concat($sio,'SIO_000975')"/>
<xsl:variable name="sio:SIO_000976"    select="concat($sio,'SIO_000976')"/>
<xsl:variable name="sio:SIO_000977"    select="concat($sio,'SIO_000977')"/>
<xsl:variable name="sio:SIO_000978"    select="concat($sio,'SIO_000978')"/>
<xsl:variable name="sio:SIO_000979"    select="concat($sio,'SIO_000979')"/>
<xsl:variable name="sio:SIO_000980"    select="concat($sio,'SIO_000980')"/>
<xsl:variable name="sio:SIO_000981"    select="concat($sio,'SIO_000981')"/>
<xsl:variable name="sio:SIO_000982"    select="concat($sio,'SIO_000982')"/>
<xsl:variable name="sio:SIO_000983"    select="concat($sio,'SIO_000983')"/>
<xsl:variable name="sio:SIO_000984"    select="concat($sio,'SIO_000984')"/>
<xsl:variable name="sio:SIO_000985"    select="concat($sio,'SIO_000985')"/>
<xsl:variable name="sio:SIO_000986"    select="concat($sio,'SIO_000986')"/>
<xsl:variable name="sio:SIO_000987"    select="concat($sio,'SIO_000987')"/>
<xsl:variable name="sio:SIO_000988"    select="concat($sio,'SIO_000988')"/>
<xsl:variable name="sio:SIO_000989"    select="concat($sio,'SIO_000989')"/>
<xsl:variable name="sio:SIO_000991"    select="concat($sio,'SIO_000991')"/>
<xsl:variable name="sio:SIO_000992"    select="concat($sio,'SIO_000992')"/>
<xsl:variable name="sio:SIO_000993"    select="concat($sio,'SIO_000993')"/>
<xsl:variable name="sio:SIO_000994"    select="concat($sio,'SIO_000994')"/>
<xsl:variable name="sio:SIO_000995"    select="concat($sio,'SIO_000995')"/>
<xsl:variable name="sio:SIO_000996"    select="concat($sio,'SIO_000996')"/>
<xsl:variable name="sio:SIO_000997"    select="concat($sio,'SIO_000997')"/>
<xsl:variable name="sio:SIO_000998"    select="concat($sio,'SIO_000998')"/>
<xsl:variable name="sio:SIO_000999"    select="concat($sio,'SIO_000999')"/>
<xsl:variable name="sio:SIO_001000"    select="concat($sio,'SIO_001000')"/>
<xsl:variable name="sio:SIO_001001"    select="concat($sio,'SIO_001001')"/>
<xsl:variable name="sio:SIO_001002"    select="concat($sio,'SIO_001002')"/>
<xsl:variable name="sio:SIO_001003"    select="concat($sio,'SIO_001003')"/>
<xsl:variable name="sio:SIO_001004"    select="concat($sio,'SIO_001004')"/>
<xsl:variable name="sio:SIO_001005"    select="concat($sio,'SIO_001005')"/>
<xsl:variable name="sio:SIO_001006"    select="concat($sio,'SIO_001006')"/>
<xsl:variable name="sio:SIO_001007"    select="concat($sio,'SIO_001007')"/>
<xsl:variable name="sio:SIO_001008"    select="concat($sio,'SIO_001008')"/>
<xsl:variable name="sio:SIO_001009"    select="concat($sio,'SIO_001009')"/>
<xsl:variable name="sio:SIO_001010"    select="concat($sio,'SIO_001010')"/>
<xsl:variable name="sio:SIO_001011"    select="concat($sio,'SIO_001011')"/>
<xsl:variable name="sio:SIO_001012"    select="concat($sio,'SIO_001012')"/>
<xsl:variable name="sio:SIO_001013"    select="concat($sio,'SIO_001013')"/>
<xsl:variable name="sio:SIO_001014"    select="concat($sio,'SIO_001014')"/>
<xsl:variable name="sio:SIO_001015"    select="concat($sio,'SIO_001015')"/>
<xsl:variable name="sio:SIO_001016"    select="concat($sio,'SIO_001016')"/>
<xsl:variable name="sio:SIO_001017"    select="concat($sio,'SIO_001017')"/>
<xsl:variable name="sio:SIO_001018"    select="concat($sio,'SIO_001018')"/>
<xsl:variable name="sio:SIO_001019"    select="concat($sio,'SIO_001019')"/>
<xsl:variable name="sio:SIO_001020"    select="concat($sio,'SIO_001020')"/>
<xsl:variable name="sio:SIO_001021"    select="concat($sio,'SIO_001021')"/>
<xsl:variable name="sio:SIO_001022"    select="concat($sio,'SIO_001022')"/>
<xsl:variable name="sio:SIO_001023"    select="concat($sio,'SIO_001023')"/>
<xsl:variable name="sio:SIO_001024"    select="concat($sio,'SIO_001024')"/>
<xsl:variable name="sio:SIO_001025"    select="concat($sio,'SIO_001025')"/>
<xsl:variable name="sio:SIO_001026"    select="concat($sio,'SIO_001026')"/>
<xsl:variable name="sio:SIO_001027"    select="concat($sio,'SIO_001027')"/>
<xsl:variable name="sio:SIO_001028"    select="concat($sio,'SIO_001028')"/>
<xsl:variable name="sio:SIO_001029"    select="concat($sio,'SIO_001029')"/>
<xsl:variable name="sio:SIO_001030"    select="concat($sio,'SIO_001030')"/>
<xsl:variable name="sio:SIO_001031"    select="concat($sio,'SIO_001031')"/>
<xsl:variable name="sio:SIO_001032"    select="concat($sio,'SIO_001032')"/>
<xsl:variable name="sio:SIO_001033"    select="concat($sio,'SIO_001033')"/>
<xsl:variable name="sio:SIO_001034"    select="concat($sio,'SIO_001034')"/>
<xsl:variable name="sio:SIO_001035"    select="concat($sio,'SIO_001035')"/>
<xsl:variable name="sio:SIO_001036"    select="concat($sio,'SIO_001036')"/>
<xsl:variable name="sio:SIO_001037"    select="concat($sio,'SIO_001037')"/>
<xsl:variable name="sio:SIO_001038"    select="concat($sio,'SIO_001038')"/>
<xsl:variable name="sio:SIO_001039"    select="concat($sio,'SIO_001039')"/>
<xsl:variable name="sio:SIO_001040"    select="concat($sio,'SIO_001040')"/>
<xsl:variable name="sio:SIO_001041"    select="concat($sio,'SIO_001041')"/>
<xsl:variable name="sio:SIO_001042"    select="concat($sio,'SIO_001042')"/>
<xsl:variable name="sio:SIO_001043"    select="concat($sio,'SIO_001043')"/>
<xsl:variable name="sio:SIO_001044"    select="concat($sio,'SIO_001044')"/>
<xsl:variable name="sio:SIO_001045"    select="concat($sio,'SIO_001045')"/>
<xsl:variable name="sio:SIO_001046"    select="concat($sio,'SIO_001046')"/>
<xsl:variable name="sio:SIO_001047"    select="concat($sio,'SIO_001047')"/>
<xsl:variable name="sio:SIO_001048"    select="concat($sio,'SIO_001048')"/>
<xsl:variable name="sio:SIO_001049"    select="concat($sio,'SIO_001049')"/>
<xsl:variable name="sio:SIO_001050"    select="concat($sio,'SIO_001050')"/>
<xsl:variable name="sio:SIO_001051"    select="concat($sio,'SIO_001051')"/>
<xsl:variable name="sio:SIO_001052"    select="concat($sio,'SIO_001052')"/>
<xsl:variable name="sio:SIO_001053"    select="concat($sio,'SIO_001053')"/>
<xsl:variable name="sio:SIO_001054"    select="concat($sio,'SIO_001054')"/>
<xsl:variable name="sio:SIO_001055"    select="concat($sio,'SIO_001055')"/>
<xsl:variable name="sio:SIO_001056"    select="concat($sio,'SIO_001056')"/>
<xsl:variable name="sio:SIO_001057"    select="concat($sio,'SIO_001057')"/>
<xsl:variable name="sio:SIO_001058"    select="concat($sio,'SIO_001058')"/>
<xsl:variable name="sio:SIO_001059"    select="concat($sio,'SIO_001059')"/>
<xsl:variable name="sio:SIO_001060"    select="concat($sio,'SIO_001060')"/>
<xsl:variable name="sio:SIO_001061"    select="concat($sio,'SIO_001061')"/>
<xsl:variable name="sio:SIO_001062"    select="concat($sio,'SIO_001062')"/>
<xsl:variable name="sio:SIO_001063"    select="concat($sio,'SIO_001063')"/>
<xsl:variable name="sio:SIO_001064"    select="concat($sio,'SIO_001064')"/>
<xsl:variable name="sio:SIO_001065"    select="concat($sio,'SIO_001065')"/>
<xsl:variable name="sio:SIO_001066"    select="concat($sio,'SIO_001066')"/>
<xsl:variable name="sio:SIO_001067"    select="concat($sio,'SIO_001067')"/>
<xsl:variable name="sio:SIO_001068"    select="concat($sio,'SIO_001068')"/>
<xsl:variable name="sio:SIO_001069"    select="concat($sio,'SIO_001069')"/>
<xsl:variable name="sio:SIO_001070"    select="concat($sio,'SIO_001070')"/>
<xsl:variable name="sio:SIO_001071"    select="concat($sio,'SIO_001071')"/>
<xsl:variable name="sio:SIO_001072"    select="concat($sio,'SIO_001072')"/>
<xsl:variable name="sio:SIO_001073"    select="concat($sio,'SIO_001073')"/>
<xsl:variable name="sio:SIO_001074"    select="concat($sio,'SIO_001074')"/>
<xsl:variable name="sio:SIO_001075"    select="concat($sio,'SIO_001075')"/>
<xsl:variable name="sio:SIO_001076"    select="concat($sio,'SIO_001076')"/>
<xsl:variable name="sio:SIO_001077"    select="concat($sio,'SIO_001077')"/>
<xsl:variable name="sio:SIO_001078"    select="concat($sio,'SIO_001078')"/>
<xsl:variable name="sio:SIO_001079"    select="concat($sio,'SIO_001079')"/>
<xsl:variable name="sio:SIO_001080"    select="concat($sio,'SIO_001080')"/>
<xsl:variable name="sio:SIO_001081"    select="concat($sio,'SIO_001081')"/>
<xsl:variable name="sio:SIO_001082"    select="concat($sio,'SIO_001082')"/>
<xsl:variable name="sio:SIO_001083"    select="concat($sio,'SIO_001083')"/>
<xsl:variable name="sio:SIO_001084"    select="concat($sio,'SIO_001084')"/>
<xsl:variable name="sio:SIO_001085"    select="concat($sio,'SIO_001085')"/>
<xsl:variable name="sio:SIO_001086"    select="concat($sio,'SIO_001086')"/>
<xsl:variable name="sio:SIO_001087"    select="concat($sio,'SIO_001087')"/>
<xsl:variable name="sio:SIO_001088"    select="concat($sio,'SIO_001088')"/>
<xsl:variable name="sio:SIO_001089"    select="concat($sio,'SIO_001089')"/>
<xsl:variable name="sio:SIO_001090"    select="concat($sio,'SIO_001090')"/>
<xsl:variable name="sio:SIO_001091"    select="concat($sio,'SIO_001091')"/>
<xsl:variable name="sio:SIO_001092"    select="concat($sio,'SIO_001092')"/>
<xsl:variable name="sio:SIO_001093"    select="concat($sio,'SIO_001093')"/>
<xsl:variable name="sio:SIO_001094"    select="concat($sio,'SIO_001094')"/>
<xsl:variable name="sio:SIO_001095"    select="concat($sio,'SIO_001095')"/>
<xsl:variable name="sio:SIO_001096"    select="concat($sio,'SIO_001096')"/>
<xsl:variable name="sio:SIO_001097"    select="concat($sio,'SIO_001097')"/>
<xsl:variable name="sio:SIO_001098"    select="concat($sio,'SIO_001098')"/>
<xsl:variable name="sio:SIO_001099"    select="concat($sio,'SIO_001099')"/>
<xsl:variable name="sio:SIO_001100"    select="concat($sio,'SIO_001100')"/>
<xsl:variable name="sio:SIO_001101"    select="concat($sio,'SIO_001101')"/>
<xsl:variable name="sio:SIO_001102"    select="concat($sio,'SIO_001102')"/>
<xsl:variable name="sio:SIO_001103"    select="concat($sio,'SIO_001103')"/>
<xsl:variable name="sio:SIO_001104"    select="concat($sio,'SIO_001104')"/>
<xsl:variable name="sio:SIO_001105"    select="concat($sio,'SIO_001105')"/>
<xsl:variable name="sio:SIO_001106"    select="concat($sio,'SIO_001106')"/>
<xsl:variable name="sio:SIO_001107"    select="concat($sio,'SIO_001107')"/>
<xsl:variable name="sio:SIO_001108"    select="concat($sio,'SIO_001108')"/>
<xsl:variable name="sio:SIO_001109"    select="concat($sio,'SIO_001109')"/>
<xsl:variable name="sio:SIO_001110"    select="concat($sio,'SIO_001110')"/>
<xsl:variable name="sio:SIO_001111"    select="concat($sio,'SIO_001111')"/>
<xsl:variable name="sio:SIO_001112"    select="concat($sio,'SIO_001112')"/>
<xsl:variable name="sio:SIO_001113"    select="concat($sio,'SIO_001113')"/>
<xsl:variable name="sio:SIO_001114"    select="concat($sio,'SIO_001114')"/>
<xsl:variable name="sio:SIO_001115"    select="concat($sio,'SIO_001115')"/>
<xsl:variable name="sio:SIO_001116"    select="concat($sio,'SIO_001116')"/>
<xsl:variable name="sio:SIO_001117"    select="concat($sio,'SIO_001117')"/>
<xsl:variable name="sio:SIO_001118"    select="concat($sio,'SIO_001118')"/>
<xsl:variable name="sio:SIO_001119"    select="concat($sio,'SIO_001119')"/>
<xsl:variable name="sio:SIO_001120"    select="concat($sio,'SIO_001120')"/>
<xsl:variable name="sio:SIO_001121"    select="concat($sio,'SIO_001121')"/>
<xsl:variable name="sio:SIO_001122"    select="concat($sio,'SIO_001122')"/>
<xsl:variable name="sio:SIO_001123"    select="concat($sio,'SIO_001123')"/>
<xsl:variable name="sio:SIO_001124"    select="concat($sio,'SIO_001124')"/>
<xsl:variable name="sio:SIO_001125"    select="concat($sio,'SIO_001125')"/>
<xsl:variable name="sio:SIO_001126"    select="concat($sio,'SIO_001126')"/>
<xsl:variable name="sio:SIO_001127"    select="concat($sio,'SIO_001127')"/>
<xsl:variable name="sio:SIO_001128"    select="concat($sio,'SIO_001128')"/>
<xsl:variable name="sio:SIO_001129"    select="concat($sio,'SIO_001129')"/>
<xsl:variable name="sio:SIO_001130"    select="concat($sio,'SIO_001130')"/>
<xsl:variable name="sio:SIO_001131"    select="concat($sio,'SIO_001131')"/>
<xsl:variable name="sio:SIO_001132"    select="concat($sio,'SIO_001132')"/>
<xsl:variable name="sio:SIO_001133"    select="concat($sio,'SIO_001133')"/>
<xsl:variable name="sio:SIO_001134"    select="concat($sio,'SIO_001134')"/>
<xsl:variable name="sio:SIO_001135"    select="concat($sio,'SIO_001135')"/>
<xsl:variable name="sio:SIO_001136"    select="concat($sio,'SIO_001136')"/>
<xsl:variable name="sio:SIO_001137"    select="concat($sio,'SIO_001137')"/>
<xsl:variable name="sio:SIO_001138"    select="concat($sio,'SIO_001138')"/>
<xsl:variable name="sio:SIO_001139"    select="concat($sio,'SIO_001139')"/>
<xsl:variable name="sio:SIO_001140"    select="concat($sio,'SIO_001140')"/>
<xsl:variable name="sio:SIO_001141"    select="concat($sio,'SIO_001141')"/>
<xsl:variable name="sio:SIO_001142"    select="concat($sio,'SIO_001142')"/>
<xsl:variable name="sio:SIO_001143"    select="concat($sio,'SIO_001143')"/>
<xsl:variable name="sio:SIO_001144"    select="concat($sio,'SIO_001144')"/>
<xsl:variable name="sio:SIO_001145"    select="concat($sio,'SIO_001145')"/>
<xsl:variable name="sio:SIO_001146"    select="concat($sio,'SIO_001146')"/>
<xsl:variable name="sio:SIO_001147"    select="concat($sio,'SIO_001147')"/>
<xsl:variable name="sio:SIO_001148"    select="concat($sio,'SIO_001148')"/>
<xsl:variable name="sio:SIO_001149"    select="concat($sio,'SIO_001149')"/>
<xsl:variable name="sio:SIO_001150"    select="concat($sio,'SIO_001150')"/>
<xsl:variable name="sio:SIO_001151"    select="concat($sio,'SIO_001151')"/>
<xsl:variable name="sio:SIO_001152"    select="concat($sio,'SIO_001152')"/>
<xsl:variable name="sio:SIO_001153"    select="concat($sio,'SIO_001153')"/>
<xsl:variable name="sio:SIO_001154"    select="concat($sio,'SIO_001154')"/>
<xsl:variable name="sio:SIO_001155"    select="concat($sio,'SIO_001155')"/>
<xsl:variable name="sio:SIO_001156"    select="concat($sio,'SIO_001156')"/>
<xsl:variable name="sio:SIO_001157"    select="concat($sio,'SIO_001157')"/>
<xsl:variable name="sio:SIO_001158"    select="concat($sio,'SIO_001158')"/>
<xsl:variable name="sio:SIO_001159"    select="concat($sio,'SIO_001159')"/>
<xsl:variable name="sio:SIO_001160"    select="concat($sio,'SIO_001160')"/>
<xsl:variable name="sio:SIO_001161"    select="concat($sio,'SIO_001161')"/>
<xsl:variable name="sio:SIO_001162"    select="concat($sio,'SIO_001162')"/>
<xsl:variable name="sio:SIO_001163"    select="concat($sio,'SIO_001163')"/>
<xsl:variable name="sio:SIO_001164"    select="concat($sio,'SIO_001164')"/>
<xsl:variable name="sio:SIO_001165"    select="concat($sio,'SIO_001165')"/>
<xsl:variable name="sio:SIO_001166"    select="concat($sio,'SIO_001166')"/>
<xsl:variable name="sio:SIO_001167"    select="concat($sio,'SIO_001167')"/>
<xsl:variable name="sio:SIO_001168"    select="concat($sio,'SIO_001168')"/>
<xsl:variable name="sio:SIO_001169"    select="concat($sio,'SIO_001169')"/>
<xsl:variable name="sio:SIO_001170"    select="concat($sio,'SIO_001170')"/>
<xsl:variable name="sio:SIO_001171"    select="concat($sio,'SIO_001171')"/>
<xsl:variable name="sio:SIO_001172"    select="concat($sio,'SIO_001172')"/>
<xsl:variable name="sio:SIO_001173"    select="concat($sio,'SIO_001173')"/>
<xsl:variable name="sio:SIO_001174"    select="concat($sio,'SIO_001174')"/>
<xsl:variable name="sio:SIO_001175"    select="concat($sio,'SIO_001175')"/>
<xsl:variable name="sio:SIO_001176"    select="concat($sio,'SIO_001176')"/>
<xsl:variable name="sio:SIO_001177"    select="concat($sio,'SIO_001177')"/>
<xsl:variable name="sio:SIO_001178"    select="concat($sio,'SIO_001178')"/>
<xsl:variable name="sio:SIO_001179"    select="concat($sio,'SIO_001179')"/>
<xsl:variable name="sio:SIO_001180"    select="concat($sio,'SIO_001180')"/>
<xsl:variable name="sio:SIO_001181"    select="concat($sio,'SIO_001181')"/>
<xsl:variable name="sio:SIO_001182"    select="concat($sio,'SIO_001182')"/>
<xsl:variable name="sio:SIO_001183"    select="concat($sio,'SIO_001183')"/>
<xsl:variable name="sio:SIO_001184"    select="concat($sio,'SIO_001184')"/>
<xsl:variable name="sio:SIO_001185"    select="concat($sio,'SIO_001185')"/>
<xsl:variable name="sio:SIO_010000"    select="concat($sio,'SIO_010000')"/>
<xsl:variable name="sio:SIO_010001"    select="concat($sio,'SIO_010001')"/>
<xsl:variable name="sio:SIO_010002"    select="concat($sio,'SIO_010002')"/>
<xsl:variable name="sio:SIO_010003"    select="concat($sio,'SIO_010003')"/>
<xsl:variable name="sio:SIO_010004"    select="concat($sio,'SIO_010004')"/>
<xsl:variable name="sio:SIO_010005"    select="concat($sio,'SIO_010005')"/>
<xsl:variable name="sio:SIO_010007"    select="concat($sio,'SIO_010007')"/>
<xsl:variable name="sio:SIO_010008"    select="concat($sio,'SIO_010008')"/>
<xsl:variable name="sio:SIO_010009"    select="concat($sio,'SIO_010009')"/>
<xsl:variable name="sio:SIO_010010"    select="concat($sio,'SIO_010010')"/>
<xsl:variable name="sio:SIO_010011"    select="concat($sio,'SIO_010011')"/>
<xsl:variable name="sio:SIO_010013"    select="concat($sio,'SIO_010013')"/>
<xsl:variable name="sio:SIO_010014"    select="concat($sio,'SIO_010014')"/>
<xsl:variable name="sio:SIO_010015"    select="concat($sio,'SIO_010015')"/>
<xsl:variable name="sio:SIO_010016"    select="concat($sio,'SIO_010016')"/>
<xsl:variable name="sio:SIO_010017"    select="concat($sio,'SIO_010017')"/>
<xsl:variable name="sio:SIO_010018"    select="concat($sio,'SIO_010018')"/>
<xsl:variable name="sio:SIO_010019"    select="concat($sio,'SIO_010019')"/>
<xsl:variable name="sio:SIO_010020"    select="concat($sio,'SIO_010020')"/>
<xsl:variable name="sio:SIO_010022"    select="concat($sio,'SIO_010022')"/>
<xsl:variable name="sio:SIO_010023"    select="concat($sio,'SIO_010023')"/>
<xsl:variable name="sio:SIO_010024"    select="concat($sio,'SIO_010024')"/>
<xsl:variable name="sio:SIO_010025"    select="concat($sio,'SIO_010025')"/>
<xsl:variable name="sio:SIO_010026"    select="concat($sio,'SIO_010026')"/>
<xsl:variable name="sio:SIO_010027"    select="concat($sio,'SIO_010027')"/>
<xsl:variable name="sio:SIO_010028"    select="concat($sio,'SIO_010028')"/>
<xsl:variable name="sio:SIO_010029"    select="concat($sio,'SIO_010029')"/>
<xsl:variable name="sio:SIO_010030"    select="concat($sio,'SIO_010030')"/>
<xsl:variable name="sio:SIO_010031"    select="concat($sio,'SIO_010031')"/>
<xsl:variable name="sio:SIO_010032"    select="concat($sio,'SIO_010032')"/>
<xsl:variable name="sio:SIO_010033"    select="concat($sio,'SIO_010033')"/>
<xsl:variable name="sio:SIO_010034"    select="concat($sio,'SIO_010034')"/>
<xsl:variable name="sio:SIO_010035"    select="concat($sio,'SIO_010035')"/>
<xsl:variable name="sio:SIO_010036"    select="concat($sio,'SIO_010036')"/>
<xsl:variable name="sio:SIO_010037"    select="concat($sio,'SIO_010037')"/>
<xsl:variable name="sio:SIO_010038"    select="concat($sio,'SIO_010038')"/>
<xsl:variable name="sio:SIO_010039"    select="concat($sio,'SIO_010039')"/>
<xsl:variable name="sio:SIO_010040"    select="concat($sio,'SIO_010040')"/>
<xsl:variable name="sio:SIO_010041"    select="concat($sio,'SIO_010041')"/>
<xsl:variable name="sio:SIO_010042"    select="concat($sio,'SIO_010042')"/>
<xsl:variable name="sio:SIO_010043"    select="concat($sio,'SIO_010043')"/>
<xsl:variable name="sio:SIO_010044"    select="concat($sio,'SIO_010044')"/>
<xsl:variable name="sio:SIO_010045"    select="concat($sio,'SIO_010045')"/>
<xsl:variable name="sio:SIO_010046"    select="concat($sio,'SIO_010046')"/>
<xsl:variable name="sio:SIO_010047"    select="concat($sio,'SIO_010047')"/>
<xsl:variable name="sio:SIO_010048"    select="concat($sio,'SIO_010048')"/>
<xsl:variable name="sio:SIO_010049"    select="concat($sio,'SIO_010049')"/>
<xsl:variable name="sio:SIO_010050"    select="concat($sio,'SIO_010050')"/>
<xsl:variable name="sio:SIO_010051"    select="concat($sio,'SIO_010051')"/>
<xsl:variable name="sio:SIO_010052"    select="concat($sio,'SIO_010052')"/>
<xsl:variable name="sio:SIO_010053"    select="concat($sio,'SIO_010053')"/>
<xsl:variable name="sio:SIO_010054"    select="concat($sio,'SIO_010054')"/>
<xsl:variable name="sio:SIO_010055"    select="concat($sio,'SIO_010055')"/>
<xsl:variable name="sio:SIO_010056"    select="concat($sio,'SIO_010056')"/>
<xsl:variable name="sio:SIO_010057"    select="concat($sio,'SIO_010057')"/>
<xsl:variable name="sio:SIO_010058"    select="concat($sio,'SIO_010058')"/>
<xsl:variable name="sio:SIO_010059"    select="concat($sio,'SIO_010059')"/>
<xsl:variable name="sio:SIO_010060"    select="concat($sio,'SIO_010060')"/>
<xsl:variable name="sio:SIO_010061"    select="concat($sio,'SIO_010061')"/>
<xsl:variable name="sio:SIO_010064"    select="concat($sio,'SIO_010064')"/>
<xsl:variable name="sio:SIO_010065"    select="concat($sio,'SIO_010065')"/>
<xsl:variable name="sio:SIO_010066"    select="concat($sio,'SIO_010066')"/>
<xsl:variable name="sio:SIO_010067"    select="concat($sio,'SIO_010067')"/>
<xsl:variable name="sio:SIO_010068"    select="concat($sio,'SIO_010068')"/>
<xsl:variable name="sio:SIO_010070"    select="concat($sio,'SIO_010070')"/>
<xsl:variable name="sio:SIO_010071"    select="concat($sio,'SIO_010071')"/>
<xsl:variable name="sio:SIO_010072"    select="concat($sio,'SIO_010072')"/>
<xsl:variable name="sio:SIO_010073"    select="concat($sio,'SIO_010073')"/>
<xsl:variable name="sio:SIO_010074"    select="concat($sio,'SIO_010074')"/>
<xsl:variable name="sio:SIO_010075"    select="concat($sio,'SIO_010075')"/>
<xsl:variable name="sio:SIO_010076"    select="concat($sio,'SIO_010076')"/>
<xsl:variable name="sio:SIO_010077"    select="concat($sio,'SIO_010077')"/>
<xsl:variable name="sio:SIO_010078"    select="concat($sio,'SIO_010078')"/>
<xsl:variable name="sio:SIO_010079"    select="concat($sio,'SIO_010079')"/>
<xsl:variable name="sio:SIO_010080"    select="concat($sio,'SIO_010080')"/>
<xsl:variable name="sio:SIO_010081"    select="concat($sio,'SIO_010081')"/>
<xsl:variable name="sio:SIO_010082"    select="concat($sio,'SIO_010082')"/>
<xsl:variable name="sio:SIO_010083"    select="concat($sio,'SIO_010083')"/>
<xsl:variable name="sio:SIO_010084"    select="concat($sio,'SIO_010084')"/>
<xsl:variable name="sio:SIO_010085"    select="concat($sio,'SIO_010085')"/>
<xsl:variable name="sio:SIO_010086"    select="concat($sio,'SIO_010086')"/>
<xsl:variable name="sio:SIO_010087"    select="concat($sio,'SIO_010087')"/>
<xsl:variable name="sio:SIO_010088"    select="concat($sio,'SIO_010088')"/>
<xsl:variable name="sio:SIO_010089"    select="concat($sio,'SIO_010089')"/>
<xsl:variable name="sio:SIO_010090"    select="concat($sio,'SIO_010090')"/>
<xsl:variable name="sio:SIO_010091"    select="concat($sio,'SIO_010091')"/>
<xsl:variable name="sio:SIO_010092"    select="concat($sio,'SIO_010092')"/>
<xsl:variable name="sio:SIO_010093"    select="concat($sio,'SIO_010093')"/>
<xsl:variable name="sio:SIO_010094"    select="concat($sio,'SIO_010094')"/>
<xsl:variable name="sio:SIO_010095"    select="concat($sio,'SIO_010095')"/>
<xsl:variable name="sio:SIO_010096"    select="concat($sio,'SIO_010096')"/>
<xsl:variable name="sio:SIO_010097"    select="concat($sio,'SIO_010097')"/>
<xsl:variable name="sio:SIO_010098"    select="concat($sio,'SIO_010098')"/>
<xsl:variable name="sio:SIO_010099"    select="concat($sio,'SIO_010099')"/>
<xsl:variable name="sio:SIO_010100"    select="concat($sio,'SIO_010100')"/>
<xsl:variable name="sio:SIO_010101"    select="concat($sio,'SIO_010101')"/>
<xsl:variable name="sio:SIO_010277"    select="concat($sio,'SIO_010277')"/>
<xsl:variable name="sio:SIO_010278"    select="concat($sio,'SIO_010278')"/>
<xsl:variable name="sio:SIO_010283"    select="concat($sio,'SIO_010283')"/>
<xsl:variable name="sio:SIO_010284"    select="concat($sio,'SIO_010284')"/>
<xsl:variable name="sio:SIO_010285"    select="concat($sio,'SIO_010285')"/>
<xsl:variable name="sio:SIO_010286"    select="concat($sio,'SIO_010286')"/>
<xsl:variable name="sio:SIO_010287"    select="concat($sio,'SIO_010287')"/>
<xsl:variable name="sio:SIO_010288"    select="concat($sio,'SIO_010288')"/>
<xsl:variable name="sio:SIO_010289"    select="concat($sio,'SIO_010289')"/>
<xsl:variable name="sio:SIO_010295"    select="concat($sio,'SIO_010295')"/>
<xsl:variable name="sio:SIO_010296"    select="concat($sio,'SIO_010296')"/>
<xsl:variable name="sio:SIO_010298"    select="concat($sio,'SIO_010298')"/>
<xsl:variable name="sio:SIO_010299"    select="concat($sio,'SIO_010299')"/>
<xsl:variable name="sio:SIO_010300"    select="concat($sio,'SIO_010300')"/>
<xsl:variable name="sio:SIO_010301"    select="concat($sio,'SIO_010301')"/>
<xsl:variable name="sio:SIO_010302"    select="concat($sio,'SIO_010302')"/>
<xsl:variable name="sio:SIO_010307"    select="concat($sio,'SIO_010307')"/>
<xsl:variable name="sio:SIO_010308"    select="concat($sio,'SIO_010308')"/>
<xsl:variable name="sio:SIO_010309"    select="concat($sio,'SIO_010309')"/>
<xsl:variable name="sio:SIO_010310"    select="concat($sio,'SIO_010310')"/>
<xsl:variable name="sio:SIO_010334"    select="concat($sio,'SIO_010334')"/>
<xsl:variable name="sio:SIO_010335"    select="concat($sio,'SIO_010335')"/>
<xsl:variable name="sio:SIO_010336"    select="concat($sio,'SIO_010336')"/>
<xsl:variable name="sio:SIO_010337"    select="concat($sio,'SIO_010337')"/>
<xsl:variable name="sio:SIO_010338"    select="concat($sio,'SIO_010338')"/>
<xsl:variable name="sio:SIO_010340"    select="concat($sio,'SIO_010340')"/>
<xsl:variable name="sio:SIO_010341"    select="concat($sio,'SIO_010341')"/>
<xsl:variable name="sio:SIO_010342"    select="concat($sio,'SIO_010342')"/>
<xsl:variable name="sio:SIO_010343"    select="concat($sio,'SIO_010343')"/>
<xsl:variable name="sio:SIO_010344"    select="concat($sio,'SIO_010344')"/>
<xsl:variable name="sio:SIO_010345"    select="concat($sio,'SIO_010345')"/>
<xsl:variable name="sio:SIO_010346"    select="concat($sio,'SIO_010346')"/>
<xsl:variable name="sio:SIO_010347"    select="concat($sio,'SIO_010347')"/>
<xsl:variable name="sio:SIO_010349"    select="concat($sio,'SIO_010349')"/>
<xsl:variable name="sio:SIO_010351"    select="concat($sio,'SIO_010351')"/>
<xsl:variable name="sio:SIO_010353"    select="concat($sio,'SIO_010353')"/>
<xsl:variable name="sio:SIO_010354"    select="concat($sio,'SIO_010354')"/>
<xsl:variable name="sio:SIO_010355"    select="concat($sio,'SIO_010355')"/>
<xsl:variable name="sio:SIO_010358"    select="concat($sio,'SIO_010358')"/>
<xsl:variable name="sio:SIO_010359"    select="concat($sio,'SIO_010359')"/>
<xsl:variable name="sio:SIO_010360"    select="concat($sio,'SIO_010360')"/>
<xsl:variable name="sio:SIO_010362"    select="concat($sio,'SIO_010362')"/>
<xsl:variable name="sio:SIO_010363"    select="concat($sio,'SIO_010363')"/>
<xsl:variable name="sio:SIO_010364"    select="concat($sio,'SIO_010364')"/>
<xsl:variable name="sio:SIO_010365"    select="concat($sio,'SIO_010365')"/>
<xsl:variable name="sio:SIO_010366"    select="concat($sio,'SIO_010366')"/>
<xsl:variable name="sio:SIO_010367"    select="concat($sio,'SIO_010367')"/>
<xsl:variable name="sio:SIO_010368"    select="concat($sio,'SIO_010368')"/>
<xsl:variable name="sio:SIO_010369"    select="concat($sio,'SIO_010369')"/>
<xsl:variable name="sio:SIO_010370"    select="concat($sio,'SIO_010370')"/>
<xsl:variable name="sio:SIO_010371"    select="concat($sio,'SIO_010371')"/>
<xsl:variable name="sio:SIO_010372"    select="concat($sio,'SIO_010372')"/>
<xsl:variable name="sio:SIO_010373"    select="concat($sio,'SIO_010373')"/>
<xsl:variable name="sio:SIO_010374"    select="concat($sio,'SIO_010374')"/>
<xsl:variable name="sio:SIO_010375"    select="concat($sio,'SIO_010375')"/>
<xsl:variable name="sio:SIO_010376"    select="concat($sio,'SIO_010376')"/>
<xsl:variable name="sio:SIO_010377"    select="concat($sio,'SIO_010377')"/>
<xsl:variable name="sio:SIO_010378"    select="concat($sio,'SIO_010378')"/>
<xsl:variable name="sio:SIO_010379"    select="concat($sio,'SIO_010379')"/>
<xsl:variable name="sio:SIO_010383"    select="concat($sio,'SIO_010383')"/>
<xsl:variable name="sio:SIO_010410"    select="concat($sio,'SIO_010410')"/>
<xsl:variable name="sio:SIO_010411"    select="concat($sio,'SIO_010411')"/>
<xsl:variable name="sio:SIO_010412"    select="concat($sio,'SIO_010412')"/>
<xsl:variable name="sio:SIO_010414"    select="concat($sio,'SIO_010414')"/>
<xsl:variable name="sio:SIO_010415"    select="concat($sio,'SIO_010415')"/>
<xsl:variable name="sio:SIO_010416"    select="concat($sio,'SIO_010416')"/>
<xsl:variable name="sio:SIO_010417"    select="concat($sio,'SIO_010417')"/>
<xsl:variable name="sio:SIO_010418"    select="concat($sio,'SIO_010418')"/>
<xsl:variable name="sio:SIO_010419"    select="concat($sio,'SIO_010419')"/>
<xsl:variable name="sio:SIO_010420"    select="concat($sio,'SIO_010420')"/>
<xsl:variable name="sio:SIO_010423"    select="concat($sio,'SIO_010423')"/>
<xsl:variable name="sio:SIO_010424"    select="concat($sio,'SIO_010424')"/>
<xsl:variable name="sio:SIO_010425"    select="concat($sio,'SIO_010425')"/>
<xsl:variable name="sio:SIO_010426"    select="concat($sio,'SIO_010426')"/>
<xsl:variable name="sio:SIO_010427"    select="concat($sio,'SIO_010427')"/>
<xsl:variable name="sio:SIO_010428"    select="concat($sio,'SIO_010428')"/>
<xsl:variable name="sio:SIO_010429"    select="concat($sio,'SIO_010429')"/>
<xsl:variable name="sio:SIO_010430"    select="concat($sio,'SIO_010430')"/>
<xsl:variable name="sio:SIO_010431"    select="concat($sio,'SIO_010431')"/>
<xsl:variable name="sio:SIO_010432"    select="concat($sio,'SIO_010432')"/>
<xsl:variable name="sio:SIO_010433"    select="concat($sio,'SIO_010433')"/>
<xsl:variable name="sio:SIO_010434"    select="concat($sio,'SIO_010434')"/>
<xsl:variable name="sio:SIO_010435"    select="concat($sio,'SIO_010435')"/>
<xsl:variable name="sio:SIO_010436"    select="concat($sio,'SIO_010436')"/>
<xsl:variable name="sio:SIO_010437"    select="concat($sio,'SIO_010437')"/>
<xsl:variable name="sio:SIO_010438"    select="concat($sio,'SIO_010438')"/>
<xsl:variable name="sio:SIO_010439"    select="concat($sio,'SIO_010439')"/>
<xsl:variable name="sio:SIO_010440"    select="concat($sio,'SIO_010440')"/>
<xsl:variable name="sio:SIO_010441"    select="concat($sio,'SIO_010441')"/>
<xsl:variable name="sio:SIO_010442"    select="concat($sio,'SIO_010442')"/>
<xsl:variable name="sio:SIO_010443"    select="concat($sio,'SIO_010443')"/>
<xsl:variable name="sio:SIO_010444"    select="concat($sio,'SIO_010444')"/>
<xsl:variable name="sio:SIO_010445"    select="concat($sio,'SIO_010445')"/>
<xsl:variable name="sio:SIO_010446"    select="concat($sio,'SIO_010446')"/>
<xsl:variable name="sio:SIO_010447"    select="concat($sio,'SIO_010447')"/>
<xsl:variable name="sio:SIO_010448"    select="concat($sio,'SIO_010448')"/>
<xsl:variable name="sio:SIO_010450"    select="concat($sio,'SIO_010450')"/>
<xsl:variable name="sio:SIO_010451"    select="concat($sio,'SIO_010451')"/>
<xsl:variable name="sio:SIO_010452"    select="concat($sio,'SIO_010452')"/>
<xsl:variable name="sio:SIO_010453"    select="concat($sio,'SIO_010453')"/>
<xsl:variable name="sio:SIO_010454"    select="concat($sio,'SIO_010454')"/>
<xsl:variable name="sio:SIO_010455"    select="concat($sio,'SIO_010455')"/>
<xsl:variable name="sio:SIO_010456"    select="concat($sio,'SIO_010456')"/>
<xsl:variable name="sio:SIO_010457"    select="concat($sio,'SIO_010457')"/>
<xsl:variable name="sio:SIO_010458"    select="concat($sio,'SIO_010458')"/>
<xsl:variable name="sio:SIO_010459"    select="concat($sio,'SIO_010459')"/>
<xsl:variable name="sio:SIO_010460"    select="concat($sio,'SIO_010460')"/>
<xsl:variable name="sio:SIO_010461"    select="concat($sio,'SIO_010461')"/>
<xsl:variable name="sio:SIO_010462"    select="concat($sio,'SIO_010462')"/>
<xsl:variable name="sio:SIO_010463"    select="concat($sio,'SIO_010463')"/>
<xsl:variable name="sio:SIO_010464"    select="concat($sio,'SIO_010464')"/>
<xsl:variable name="sio:SIO_010465"    select="concat($sio,'SIO_010465')"/>
<xsl:variable name="sio:SIO_010468"    select="concat($sio,'SIO_010468')"/>
<xsl:variable name="sio:SIO_010469"    select="concat($sio,'SIO_010469')"/>
<xsl:variable name="sio:SIO_010471"    select="concat($sio,'SIO_010471')"/>
<xsl:variable name="sio:SIO_010496"    select="concat($sio,'SIO_010496')"/>
<xsl:variable name="sio:SIO_010497"    select="concat($sio,'SIO_010497')"/>
<xsl:variable name="sio:SIO_010498"    select="concat($sio,'SIO_010498')"/>
<xsl:variable name="sio:SIO_010499"    select="concat($sio,'SIO_010499')"/>
<xsl:variable name="sio:SIO_010500"    select="concat($sio,'SIO_010500')"/>
<xsl:variable name="sio:SIO_010501"    select="concat($sio,'SIO_010501')"/>
<xsl:variable name="sio:SIO_010502"    select="concat($sio,'SIO_010502')"/>
<xsl:variable name="sio:SIO_010503"    select="concat($sio,'SIO_010503')"/>
<xsl:variable name="sio:SIO_010504"    select="concat($sio,'SIO_010504')"/>
<xsl:variable name="sio:SIO_010505"    select="concat($sio,'SIO_010505')"/>
<xsl:variable name="sio:SIO_010506"    select="concat($sio,'SIO_010506')"/>
<xsl:variable name="sio:SIO_010507"    select="concat($sio,'SIO_010507')"/>
<xsl:variable name="sio:SIO_010508"    select="concat($sio,'SIO_010508')"/>
<xsl:variable name="sio:SIO_010509"    select="concat($sio,'SIO_010509')"/>
<xsl:variable name="sio:SIO_010510"    select="concat($sio,'SIO_010510')"/>
<xsl:variable name="sio:SIO_010511"    select="concat($sio,'SIO_010511')"/>
<xsl:variable name="sio:SIO_010512"    select="concat($sio,'SIO_010512')"/>
<xsl:variable name="sio:SIO_010513"    select="concat($sio,'SIO_010513')"/>
<xsl:variable name="sio:SIO_010514"    select="concat($sio,'SIO_010514')"/>
<xsl:variable name="sio:SIO_010515"    select="concat($sio,'SIO_010515')"/>
<xsl:variable name="sio:SIO_010516"    select="concat($sio,'SIO_010516')"/>
<xsl:variable name="sio:SIO_010517"    select="concat($sio,'SIO_010517')"/>
<xsl:variable name="sio:SIO_010518"    select="concat($sio,'SIO_010518')"/>
<xsl:variable name="sio:SIO_010519"    select="concat($sio,'SIO_010519')"/>
<xsl:variable name="sio:SIO_010520"    select="concat($sio,'SIO_010520')"/>
<xsl:variable name="sio:SIO_010521"    select="concat($sio,'SIO_010521')"/>
<xsl:variable name="sio:SIO_010522"    select="concat($sio,'SIO_010522')"/>
<xsl:variable name="sio:SIO_010523"    select="concat($sio,'SIO_010523')"/>
<xsl:variable name="sio:SIO_010525"    select="concat($sio,'SIO_010525')"/>
<xsl:variable name="sio:SIO_010526"    select="concat($sio,'SIO_010526')"/>
<xsl:variable name="sio:SIO_010527"    select="concat($sio,'SIO_010527')"/>
<xsl:variable name="sio:SIO_010528"    select="concat($sio,'SIO_010528')"/>
<xsl:variable name="sio:SIO_010530"    select="concat($sio,'SIO_010530')"/>
<xsl:variable name="sio:SIO_010531"    select="concat($sio,'SIO_010531')"/>
<xsl:variable name="sio:SIO_010532"    select="concat($sio,'SIO_010532')"/>
<xsl:variable name="sio:SIO_010533"    select="concat($sio,'SIO_010533')"/>
<xsl:variable name="sio:SIO_010673"    select="concat($sio,'SIO_010673')"/>
<xsl:variable name="sio:SIO_010674"    select="concat($sio,'SIO_010674')"/>
<xsl:variable name="sio:SIO_010775"    select="concat($sio,'SIO_010775')"/>
<xsl:variable name="sio:SIO_010776"    select="concat($sio,'SIO_010776')"/>
<xsl:variable name="sio:SIO_010777"    select="concat($sio,'SIO_010777')"/>
<xsl:variable name="sio:SIO_010778"    select="concat($sio,'SIO_010778')"/>
<xsl:variable name="sio:SIO_010779"    select="concat($sio,'SIO_010779')"/>
<xsl:variable name="sio:SIO_010780"    select="concat($sio,'SIO_010780')"/>
<xsl:variable name="sio:SIO_010781"    select="concat($sio,'SIO_010781')"/>
<xsl:variable name="sio:SIO_010782"    select="concat($sio,'SIO_010782')"/>
<xsl:variable name="sio:SIO_010783"    select="concat($sio,'SIO_010783')"/>
<xsl:variable name="sio:SIO_010784"    select="concat($sio,'SIO_010784')"/>
<xsl:variable name="sio:SIO_010785"    select="concat($sio,'SIO_010785')"/>
<xsl:variable name="sio:SIO_010786"    select="concat($sio,'SIO_010786')"/>
<xsl:variable name="sio:SIO_010787"    select="concat($sio,'SIO_010787')"/>
<xsl:variable name="sio:SIO_010788"    select="concat($sio,'SIO_010788')"/>
<xsl:variable name="sio:SIO_010789"    select="concat($sio,'SIO_010789')"/>
<xsl:variable name="sio:SIO_010790"    select="concat($sio,'SIO_010790')"/>
<xsl:variable name="sio:SIO_010791"    select="concat($sio,'SIO_010791')"/>
<xsl:variable name="sio:SIO_010792"    select="concat($sio,'SIO_010792')"/>
<xsl:variable name="sio:SIO_010793"    select="concat($sio,'SIO_010793')"/>
<xsl:variable name="sio:SIO_010794"    select="concat($sio,'SIO_010794')"/>
<xsl:variable name="sio:SIO_010795"    select="concat($sio,'SIO_010795')"/>
<xsl:variable name="sio:SIO_011000"    select="concat($sio,'SIO_011000')"/>
<xsl:variable name="sio:SIO_011001"    select="concat($sio,'SIO_011001')"/>
<xsl:variable name="sio:SIO_011002"    select="concat($sio,'SIO_011002')"/>
<xsl:variable name="sio:SIO_011003"    select="concat($sio,'SIO_011003')"/>
<xsl:variable name="sio:SIO_011004"    select="concat($sio,'SIO_011004')"/>
<xsl:variable name="sio:SIO_011005"    select="concat($sio,'SIO_011005')"/>
<xsl:variable name="sio:SIO_011006"    select="concat($sio,'SIO_011006')"/>
<xsl:variable name="sio:SIO_011007"    select="concat($sio,'SIO_011007')"/>
<xsl:variable name="sio:SIO_011008"    select="concat($sio,'SIO_011008')"/>
<xsl:variable name="sio:SIO_011009"    select="concat($sio,'SIO_011009')"/>
<xsl:variable name="sio:SIO_011010"    select="concat($sio,'SIO_011010')"/>
<xsl:variable name="sio:SIO_011011"    select="concat($sio,'SIO_011011')"/>
<xsl:variable name="sio:SIO_011012"    select="concat($sio,'SIO_011012')"/>
<xsl:variable name="sio:SIO_011013"    select="concat($sio,'SIO_011013')"/>
<xsl:variable name="sio:SIO_011014"    select="concat($sio,'SIO_011014')"/>
<xsl:variable name="sio:SIO_011015"    select="concat($sio,'SIO_011015')"/>
<xsl:variable name="sio:SIO_011016"    select="concat($sio,'SIO_011016')"/>
<xsl:variable name="sio:SIO_011017"    select="concat($sio,'SIO_011017')"/>
<xsl:variable name="sio:SIO_011018"    select="concat($sio,'SIO_011018')"/>
<xsl:variable name="sio:SIO_011019"    select="concat($sio,'SIO_011019')"/>
<xsl:variable name="sio:SIO_011020"    select="concat($sio,'SIO_011020')"/>
<xsl:variable name="sio:SIO_011021"    select="concat($sio,'SIO_011021')"/>
<xsl:variable name="sio:SIO_011022"    select="concat($sio,'SIO_011022')"/>
<xsl:variable name="sio:SIO_011023"    select="concat($sio,'SIO_011023')"/>
<xsl:variable name="sio:SIO_011024"    select="concat($sio,'SIO_011024')"/>
<xsl:variable name="sio:SIO_011025"    select="concat($sio,'SIO_011025')"/>
<xsl:variable name="sio:SIO_011026"    select="concat($sio,'SIO_011026')"/>
<xsl:variable name="sio:SIO_011027"    select="concat($sio,'SIO_011027')"/>
<xsl:variable name="sio:SIO_011028"    select="concat($sio,'SIO_011028')"/>
<xsl:variable name="sio:SIO_011029"    select="concat($sio,'SIO_011029')"/>
<xsl:variable name="sio:SIO_011030"    select="concat($sio,'SIO_011030')"/>
<xsl:variable name="sio:SIO_011031"    select="concat($sio,'SIO_011031')"/>
<xsl:variable name="sio:SIO_011032"    select="concat($sio,'SIO_011032')"/>
<xsl:variable name="sio:SIO_011033"    select="concat($sio,'SIO_011033')"/>
<xsl:variable name="sio:SIO_011034"    select="concat($sio,'SIO_011034')"/>
<xsl:variable name="sio:SIO_011035"    select="concat($sio,'SIO_011035')"/>
<xsl:variable name="sio:SIO_011036"    select="concat($sio,'SIO_011036')"/>
<xsl:variable name="sio:SIO_011037"    select="concat($sio,'SIO_011037')"/>
<xsl:variable name="sio:SIO_011038"    select="concat($sio,'SIO_011038')"/>
<xsl:variable name="sio:SIO_011039"    select="concat($sio,'SIO_011039')"/>
<xsl:variable name="sio:SIO_011040"    select="concat($sio,'SIO_011040')"/>
<xsl:variable name="sio:SIO_011041"    select="concat($sio,'SIO_011041')"/>
<xsl:variable name="sio:SIO_011042"    select="concat($sio,'SIO_011042')"/>
<xsl:variable name="sio:SIO_011043"    select="concat($sio,'SIO_011043')"/>
<xsl:variable name="sio:SIO_011044"    select="concat($sio,'SIO_011044')"/>
<xsl:variable name="sio:SIO_011045"    select="concat($sio,'SIO_011045')"/>
<xsl:variable name="sio:SIO_011046"    select="concat($sio,'SIO_011046')"/>
<xsl:variable name="sio:SIO_011047"    select="concat($sio,'SIO_011047')"/>
<xsl:variable name="sio:SIO_011048"    select="concat($sio,'SIO_011048')"/>
<xsl:variable name="sio:SIO_011049"    select="concat($sio,'SIO_011049')"/>
<xsl:variable name="sio:SIO_011050"    select="concat($sio,'SIO_011050')"/>
<xsl:variable name="sio:SIO_011051"    select="concat($sio,'SIO_011051')"/>
<xsl:variable name="sio:SIO_011052"    select="concat($sio,'SIO_011052')"/>
<xsl:variable name="sio:SIO_011053"    select="concat($sio,'SIO_011053')"/>
<xsl:variable name="sio:SIO_011054"    select="concat($sio,'SIO_011054')"/>
<xsl:variable name="sio:SIO_011055"    select="concat($sio,'SIO_011055')"/>
<xsl:variable name="sio:SIO_011056"    select="concat($sio,'SIO_011056')"/>
<xsl:variable name="sio:SIO_011057"    select="concat($sio,'SIO_011057')"/>
<xsl:variable name="sio:SIO_011058"    select="concat($sio,'SIO_011058')"/>
<xsl:variable name="sio:SIO_011059"    select="concat($sio,'SIO_011059')"/>
<xsl:variable name="sio:SIO_011060"    select="concat($sio,'SIO_011060')"/>
<xsl:variable name="sio:SIO_011061"    select="concat($sio,'SIO_011061')"/>
<xsl:variable name="sio:SIO_011062"    select="concat($sio,'SIO_011062')"/>
<xsl:variable name="sio:SIO_011063"    select="concat($sio,'SIO_011063')"/>
<xsl:variable name="sio:SIO_011064"    select="concat($sio,'SIO_011064')"/>
<xsl:variable name="sio:SIO_011065"    select="concat($sio,'SIO_011065')"/>
<xsl:variable name="sio:SIO_011066"    select="concat($sio,'SIO_011066')"/>
<xsl:variable name="sio:SIO_011067"    select="concat($sio,'SIO_011067')"/>
<xsl:variable name="sio:SIO_011068"    select="concat($sio,'SIO_011068')"/>
<xsl:variable name="sio:SIO_011069"    select="concat($sio,'SIO_011069')"/>
<xsl:variable name="sio:SIO_011070"    select="concat($sio,'SIO_011070')"/>
<xsl:variable name="sio:SIO_011071"    select="concat($sio,'SIO_011071')"/>
<xsl:variable name="sio:SIO_011072"    select="concat($sio,'SIO_011072')"/>
<xsl:variable name="sio:SIO_011073"    select="concat($sio,'SIO_011073')"/>
<xsl:variable name="sio:SIO_011074"    select="concat($sio,'SIO_011074')"/>
<xsl:variable name="sio:SIO_011075"    select="concat($sio,'SIO_011075')"/>
<xsl:variable name="sio:SIO_011076"    select="concat($sio,'SIO_011076')"/>
<xsl:variable name="sio:SIO_011077"    select="concat($sio,'SIO_011077')"/>
<xsl:variable name="sio:SIO_011078"    select="concat($sio,'SIO_011078')"/>
<xsl:variable name="sio:SIO_011079"    select="concat($sio,'SIO_011079')"/>
<xsl:variable name="sio:SIO_011080"    select="concat($sio,'SIO_011080')"/>
<xsl:variable name="sio:SIO_011081"    select="concat($sio,'SIO_011081')"/>
<xsl:variable name="sio:SIO_011082"    select="concat($sio,'SIO_011082')"/>
<xsl:variable name="sio:SIO_011083"    select="concat($sio,'SIO_011083')"/>
<xsl:variable name="sio:SIO_011084"    select="concat($sio,'SIO_011084')"/>
<xsl:variable name="sio:SIO_011085"    select="concat($sio,'SIO_011085')"/>
<xsl:variable name="sio:SIO_011086"    select="concat($sio,'SIO_011086')"/>
<xsl:variable name="sio:SIO_011087"    select="concat($sio,'SIO_011087')"/>
<xsl:variable name="sio:SIO_011088"    select="concat($sio,'SIO_011088')"/>
<xsl:variable name="sio:SIO_011089"    select="concat($sio,'SIO_011089')"/>
<xsl:variable name="sio:SIO_011090"    select="concat($sio,'SIO_011090')"/>
<xsl:variable name="sio:SIO_011091"    select="concat($sio,'SIO_011091')"/>
<xsl:variable name="sio:SIO_011092"    select="concat($sio,'SIO_011092')"/>
<xsl:variable name="sio:SIO_011093"    select="concat($sio,'SIO_011093')"/>
<xsl:variable name="sio:SIO_011094"    select="concat($sio,'SIO_011094')"/>
<xsl:variable name="sio:SIO_011095"    select="concat($sio,'SIO_011095')"/>
<xsl:variable name="sio:SIO_011096"    select="concat($sio,'SIO_011096')"/>
<xsl:variable name="sio:SIO_011097"    select="concat($sio,'SIO_011097')"/>
<xsl:variable name="sio:SIO_011098"    select="concat($sio,'SIO_011098')"/>
<xsl:variable name="sio:SIO_011099"    select="concat($sio,'SIO_011099')"/>
<xsl:variable name="sio:SIO_011100"    select="concat($sio,'SIO_011100')"/>
<xsl:variable name="sio:SIO_011101"    select="concat($sio,'SIO_011101')"/>
<xsl:variable name="sio:SIO_011102"    select="concat($sio,'SIO_011102')"/>
<xsl:variable name="sio:SIO_011103"    select="concat($sio,'SIO_011103')"/>
<xsl:variable name="sio:SIO_011104"    select="concat($sio,'SIO_011104')"/>
<xsl:variable name="sio:SIO_011105"    select="concat($sio,'SIO_011105')"/>
<xsl:variable name="sio:SIO_011106"    select="concat($sio,'SIO_011106')"/>
<xsl:variable name="sio:SIO_011107"    select="concat($sio,'SIO_011107')"/>
<xsl:variable name="sio:SIO_011108"    select="concat($sio,'SIO_011108')"/>
<xsl:variable name="sio:SIO_011109"    select="concat($sio,'SIO_011109')"/>
<xsl:variable name="sio:SIO_011110"    select="concat($sio,'SIO_011110')"/>
<xsl:variable name="sio:SIO_011111"    select="concat($sio,'SIO_011111')"/>
<xsl:variable name="sio:SIO_011112"    select="concat($sio,'SIO_011112')"/>
<xsl:variable name="sio:SIO_011113"    select="concat($sio,'SIO_011113')"/>
<xsl:variable name="sio:SIO_011114"    select="concat($sio,'SIO_011114')"/>
<xsl:variable name="sio:SIO_011115"    select="concat($sio,'SIO_011115')"/>
<xsl:variable name="sio:SIO_011116"    select="concat($sio,'SIO_011116')"/>
<xsl:variable name="sio:SIO_011117"    select="concat($sio,'SIO_011117')"/>
<xsl:variable name="sio:SIO_011118"    select="concat($sio,'SIO_011118')"/>
<xsl:variable name="sio:SIO_011119"    select="concat($sio,'SIO_011119')"/>
<xsl:variable name="sio:SIO_011120"    select="concat($sio,'SIO_011120')"/>
<xsl:variable name="sio:SIO_011121"    select="concat($sio,'SIO_011121')"/>
<xsl:variable name="sio:SIO_011123"    select="concat($sio,'SIO_011123')"/>
<xsl:variable name="sio:SIO_011125"    select="concat($sio,'SIO_011125')"/>
<xsl:variable name="sio:SIO_011126"    select="concat($sio,'SIO_011126')"/>
<xsl:variable name="sio:SIO_011130"    select="concat($sio,'SIO_011130')"/>
<xsl:variable name="sio:SIO_011131"    select="concat($sio,'SIO_011131')"/>

<xsl:variable name="sio:ALL" select="(
   $sio:SIO_011060,
   $sio:SIO_011061,
   $sio:SIO_011062,
   $sio:SIO_000370,
   $sio:SIO_011063,
   $sio:SIO_000371,
   $sio:SIO_011064,
   $sio:SIO_000372,
   $sio:SIO_011065,
   $sio:SIO_000373,
   $sio:SIO_011110,
   $sio:SIO_011066,
   $sio:SIO_000374,
   $sio:SIO_011111,
   $sio:SIO_011067,
   $sio:SIO_000870,
   $sio:SIO_000375,
   $sio:SIO_011112,
   $sio:SIO_011068,
   $sio:SIO_000871,
   $sio:SIO_000376,
   $sio:SIO_000420,
   $sio:SIO_011113,
   $sio:SIO_011069,
   $sio:SIO_010673,
   $sio:SIO_000872,
   $sio:SIO_000377,
   $sio:SIO_000421,
   $sio:SIO_011114,
   $sio:SIO_010674,
   $sio:SIO_000873,
   $sio:SIO_000422,
   $sio:SIO_000378,
   $sio:SIO_011115,
   $sio:SIO_000423,
   $sio:SIO_000379,
   $sio:SIO_011116,
   $sio:SIO_000875,
   $sio:SIO_000424,
   $sio:SIO_011117,
   $sio:SIO_000920,
   $sio:SIO_000876,
   $sio:SIO_000425,
   $sio:SIO_011118,
   $sio:SIO_000921,
   $sio:SIO_000877,
   $sio:SIO_000426,
   $sio:SIO_011119,
   $sio:SIO_000922,
   $sio:SIO_000878,
   $sio:SIO_000427,
   $sio:SIO_000923,
   $sio:SIO_000879,
   $sio:SIO_000428,
   $sio:SIO_000924,
   $sio:SIO_000429,
   $sio:SIO_000926,
   $sio:SIO_000927,
   $sio:SIO_000928,
   $sio:SIO_000929,
   $sio:SIO_011070,
   $sio:SIO_011071,
   $sio:SIO_011072,
   $sio:SIO_000380,
   $sio:SIO_011073,
   $sio:SIO_000381,
   $sio:SIO_011074,
   $sio:SIO_000382,
   $sio:SIO_011075,
   $sio:SIO_000383,
   $sio:SIO_011120,
   $sio:SIO_011076,
   $sio:SIO_000384,
   $sio:SIO_011121,
   $sio:SIO_011077,
   $sio:SIO_000880,
   $sio:SIO_000385,
   $sio:SIO_011078,
   $sio:SIO_000881,
   $sio:SIO_000430,
   $sio:SIO_000386,
   $sio:SIO_011123,
   $sio:SIO_011079,
   $sio:SIO_000882,
   $sio:SIO_000431,
   $sio:SIO_000387,
   $sio:SIO_000883,
   $sio:SIO_000432,
   $sio:SIO_000388,
   $sio:SIO_011125,
   $sio:SIO_000884,
   $sio:SIO_000433,
   $sio:SIO_000389,
   $sio:SIO_011126,
   $sio:SIO_000885,
   $sio:SIO_000434,
   $sio:SIO_000930,
   $sio:SIO_000886,
   $sio:SIO_000435,
   $sio:SIO_000931,
   $sio:SIO_000887,
   $sio:SIO_000436,
   $sio:SIO_000932,
   $sio:SIO_000888,
   $sio:SIO_000437,
   $sio:SIO_000933,
   $sio:SIO_000889,
   $sio:SIO_000438,
   $sio:SIO_000934,
   $sio:SIO_000439,
   $sio:SIO_000935,
   $sio:SIO_000936,
   $sio:SIO_000937,
   $sio:SIO_000938,
   $sio:SIO_000939,
   $sio:SIO_011080,
   $sio:SIO_011081,
   $sio:SIO_011082,
   $sio:SIO_000390,
   $sio:SIO_011083,
   $sio:SIO_000391,
   $sio:SIO_011084,
   $sio:SIO_000392,
   $sio:SIO_011085,
   $sio:SIO_000393,
   $sio:SIO_011130,
   $sio:SIO_011086,
   $sio:SIO_000394,
   $sio:SIO_011131,
   $sio:SIO_011087,
   $sio:SIO_000890,
   $sio:SIO_000395,
   $sio:SIO_011088,
   $sio:SIO_000891,
   $sio:SIO_000440,
   $sio:SIO_000396,
   $sio:SIO_011089,
   $sio:SIO_000892,
   $sio:SIO_000441,
   $sio:SIO_000397,
   $sio:SIO_000893,
   $sio:SIO_000442,
   $sio:SIO_000398,
   $sio:SIO_000894,
   $sio:SIO_000443,
   $sio:SIO_000399,
   $sio:SIO_000895,
   $sio:SIO_000444,
   $sio:SIO_000940,
   $sio:SIO_000896,
   $sio:SIO_000445,
   $sio:SIO_000941,
   $sio:SIO_000897,
   $sio:SIO_000446,
   $sio:SIO_000942,
   $sio:SIO_000898,
   $sio:SIO_000447,
   $sio:SIO_000943,
   $sio:SIO_000899,
   $sio:SIO_000448,
   $sio:SIO_000944,
   $sio:SIO_000449,
   $sio:SIO_000945,
   $sio:SIO_000946,
   $sio:SIO_000947,
   $sio:SIO_000948,
   $sio:SIO_000949,
   $sio:SIO_011090,
   $sio:SIO_011091,
   $sio:SIO_011092,
   $sio:SIO_011093,
   $sio:SIO_011094,
   $sio:SIO_011095,
   $sio:SIO_011096,
   $sio:SIO_011097,
   $sio:SIO_011098,
   $sio:SIO_000450,
   $sio:SIO_011099,
   $sio:SIO_000451,
   $sio:SIO_000000,
   $sio:SIO_000452,
   $sio:SIO_000001,
   $sio:SIO_000453,
   $sio:SIO_000454,
   $sio:SIO_010300,
   $sio:SIO_000950,
   $sio:SIO_000455,
   $sio:SIO_000004,
   $sio:SIO_010301,
   $sio:SIO_000951,
   $sio:SIO_000500,
   $sio:SIO_000456,
   $sio:SIO_000005,
   $sio:SIO_010302,
   $sio:SIO_000952,
   $sio:SIO_000501,
   $sio:SIO_000457,
   $sio:SIO_000006,
   $sio:SIO_000953,
   $sio:SIO_000502,
   $sio:SIO_000458,
   $sio:SIO_000954,
   $sio:SIO_000503,
   $sio:SIO_000459,
   $sio:SIO_000008,
   $sio:SIO_000955,
   $sio:SIO_000504,
   $sio:SIO_000009,
   $sio:SIO_000956,
   $sio:SIO_000505,
   $sio:SIO_010307,
   $sio:SIO_000957,
   $sio:SIO_000506,
   $sio:SIO_010308,
   $sio:SIO_000507,
   $sio:SIO_010309,
   $sio:SIO_000959,
   $sio:SIO_000508,
   $sio:SIO_000509,
   $sio:SIO_000460,
   $sio:SIO_000461,
   $sio:SIO_000010,
   $sio:SIO_000462,
   $sio:SIO_000011,
   $sio:SIO_000463,
   $sio:SIO_000012,
   $sio:SIO_000464,
   $sio:SIO_000013,
   $sio:SIO_010310,
   $sio:SIO_000960,
   $sio:SIO_000465,
   $sio:SIO_000014,
   $sio:SIO_000961,
   $sio:SIO_000510,
   $sio:SIO_000466,
   $sio:SIO_000015,
   $sio:SIO_000962,
   $sio:SIO_000511,
   $sio:SIO_000467,
   $sio:SIO_000016,
   $sio:SIO_000963,
   $sio:SIO_000512,
   $sio:SIO_000468,
   $sio:SIO_000017,
   $sio:SIO_000964,
   $sio:SIO_000513,
   $sio:SIO_000469,
   $sio:SIO_000965,
   $sio:SIO_000514,
   $sio:SIO_000019,
   $sio:SIO_000966,
   $sio:SIO_000515,
   $sio:SIO_000967,
   $sio:SIO_000516,
   $sio:SIO_000968,
   $sio:SIO_000517,
   $sio:SIO_000969,
   $sio:SIO_000518,
   $sio:SIO_000519,
   $sio:SIO_000470,
   $sio:SIO_000471,
   $sio:SIO_000020,
   $sio:SIO_000472,
   $sio:SIO_000473,
   $sio:SIO_000022,
   $sio:SIO_000474,
   $sio:SIO_000970,
   $sio:SIO_000475,
   $sio:SIO_010277,
   $sio:SIO_000971,
   $sio:SIO_000520,
   $sio:SIO_000476,
   $sio:SIO_010278,
   $sio:SIO_000972,
   $sio:SIO_000521,
   $sio:SIO_000477,
   $sio:SIO_000026,
   $sio:SIO_000973,
   $sio:SIO_000522,
   $sio:SIO_000478,
   $sio:SIO_000027,
   $sio:SIO_010775,
   $sio:SIO_000974,
   $sio:SIO_000523,
   $sio:SIO_000479,
   $sio:SIO_000028,
   $sio:SIO_010776,
   $sio:SIO_000975,
   $sio:SIO_000524,
   $sio:SIO_000029,
   $sio:SIO_010777,
   $sio:SIO_000976,
   $sio:SIO_000525,
   $sio:SIO_010778,
   $sio:SIO_000977,
   $sio:SIO_000526,
   $sio:SIO_010779,
   $sio:SIO_000978,
   $sio:SIO_000527,
   $sio:SIO_000979,
   $sio:SIO_000528,
   $sio:SIO_000529,
   $sio:SIO_000480,
   $sio:SIO_000481,
   $sio:SIO_000030,
   $sio:SIO_010283,
   $sio:SIO_000482,
   $sio:SIO_000031,
   $sio:SIO_010284,
   $sio:SIO_000483,
   $sio:SIO_000032,
   $sio:SIO_010780,
   $sio:SIO_010285,
   $sio:SIO_000484,
   $sio:SIO_000033,
   $sio:SIO_010781,
   $sio:SIO_010286,
   $sio:SIO_000980,
   $sio:SIO_000485,
   $sio:SIO_000034,
   $sio:SIO_010782,
   $sio:SIO_010287,
   $sio:SIO_000981,
   $sio:SIO_000530,
   $sio:SIO_000486,
   $sio:SIO_000035,
   $sio:SIO_010783,
   $sio:SIO_010288,
   $sio:SIO_000982,
   $sio:SIO_000531,
   $sio:SIO_000487,
   $sio:SIO_000036,
   $sio:SIO_010784,
   $sio:SIO_010289,
   $sio:SIO_000983,
   $sio:SIO_000532,
   $sio:SIO_000488,
   $sio:SIO_000037,
   $sio:SIO_010785,
   $sio:SIO_010334,
   $sio:SIO_000984,
   $sio:SIO_000533,
   $sio:SIO_000489,
   $sio:SIO_000038,
   $sio:SIO_010786,
   $sio:SIO_010335,
   $sio:SIO_000985,
   $sio:SIO_000534,
   $sio:SIO_000039,
   $sio:SIO_010787,
   $sio:SIO_010336,
   $sio:SIO_000986,
   $sio:SIO_000535,
   $sio:SIO_010788,
   $sio:SIO_010337,
   $sio:SIO_000987,
   $sio:SIO_000536,
   $sio:SIO_010789,
   $sio:SIO_010338,
   $sio:SIO_000988,
   $sio:SIO_000537,
   $sio:SIO_000989,
   $sio:SIO_000538,
   $sio:SIO_000539,
   $sio:SIO_000490,
   $sio:SIO_000491,
   $sio:SIO_000040,
   $sio:SIO_000492,
   $sio:SIO_000041,
   $sio:SIO_000493,
   $sio:SIO_000042,
   $sio:SIO_010790,
   $sio:SIO_010295,
   $sio:SIO_000494,
   $sio:SIO_000043,
   $sio:SIO_010791,
   $sio:SIO_010340,
   $sio:SIO_010296,
   $sio:SIO_000495,
   $sio:SIO_000044,
   $sio:SIO_010792,
   $sio:SIO_010341,
   $sio:SIO_000991,
   $sio:SIO_000540,
   $sio:SIO_000496,
   $sio:SIO_000045,
   $sio:SIO_010793,
   $sio:SIO_010342,
   $sio:SIO_010298,
   $sio:SIO_000992,
   $sio:SIO_000541,
   $sio:SIO_000497,
   $sio:SIO_000046,
   $sio:SIO_010794,
   $sio:SIO_010343,
   $sio:SIO_010299,
   $sio:SIO_000993,
   $sio:SIO_000542,
   $sio:SIO_000498,
   $sio:SIO_000047,
   $sio:SIO_010795,
   $sio:SIO_010344,
   $sio:SIO_000994,
   $sio:SIO_000543,
   $sio:SIO_000499,
   $sio:SIO_000048,
   $sio:SIO_010345,
   $sio:SIO_000995,
   $sio:SIO_000544,
   $sio:SIO_000049,
   $sio:SIO_010346,
   $sio:SIO_000996,
   $sio:SIO_000545,
   $sio:SIO_010347,
   $sio:SIO_000997,
   $sio:SIO_000546,
   $sio:SIO_000998,
   $sio:SIO_000547,
   $sio:SIO_010349,
   $sio:SIO_000999,
   $sio:SIO_000549,
   $sio:SIO_000051,
   $sio:SIO_000052,
   $sio:SIO_000053,
   $sio:SIO_000054,
   $sio:SIO_010351,
   $sio:SIO_000550,
   $sio:SIO_000055,
   $sio:SIO_000551,
   $sio:SIO_000100,
   $sio:SIO_000056,
   $sio:SIO_010353,
   $sio:SIO_000552,
   $sio:SIO_000101,
   $sio:SIO_000057,
   $sio:SIO_010354,
   $sio:SIO_000553,
   $sio:SIO_000102,
   $sio:SIO_010355,
   $sio:SIO_000554,
   $sio:SIO_000103,
   $sio:SIO_000059,
   $sio:SIO_000555,
   $sio:SIO_000104,
   $sio:SIO_000600,
   $sio:SIO_000556,
   $sio:SIO_000105,
   $sio:SIO_010358,
   $sio:SIO_000557,
   $sio:SIO_000106,
   $sio:SIO_010359,
   $sio:SIO_000602,
   $sio:SIO_000558,
   $sio:SIO_000107,
   $sio:SIO_000559,
   $sio:SIO_000108,
   $sio:SIO_000109,
   $sio:SIO_000605,
   $sio:SIO_000608,
   $sio:SIO_000609,
   $sio:SIO_000060,
   $sio:SIO_000061,
   $sio:SIO_000062,
   $sio:SIO_000063,
   $sio:SIO_010360,
   $sio:SIO_000064,
   $sio:SIO_001000,
   $sio:SIO_010362,
   $sio:SIO_001001,
   $sio:SIO_000561,
   $sio:SIO_000110,
   $sio:SIO_000066,
   $sio:SIO_010363,
   $sio:SIO_001002,
   $sio:SIO_000562,
   $sio:SIO_000111,
   $sio:SIO_000067,
   $sio:SIO_010364,
   $sio:SIO_001003,
   $sio:SIO_000563,
   $sio:SIO_000112,
   $sio:SIO_000068,
   $sio:SIO_010365,
   $sio:SIO_001004,
   $sio:SIO_000564,
   $sio:SIO_000069,
   $sio:SIO_000113,
   $sio:SIO_010410,
   $sio:SIO_010366,
   $sio:SIO_001005,
   $sio:SIO_000565,
   $sio:SIO_000114,
   $sio:SIO_010411,
   $sio:SIO_010367,
   $sio:SIO_001006,
   $sio:SIO_000610,
   $sio:SIO_000566,
   $sio:SIO_000115,
   $sio:SIO_010412,
   $sio:SIO_010368,
   $sio:SIO_001007,
   $sio:SIO_000611,
   $sio:SIO_000567,
   $sio:SIO_000116,
   $sio:SIO_010369,
   $sio:SIO_001008,
   $sio:SIO_000612,
   $sio:SIO_000568,
   $sio:SIO_000117,
   $sio:SIO_010414,
   $sio:SIO_001009,
   $sio:SIO_000613,
   $sio:SIO_000569,
   $sio:SIO_000118,
   $sio:SIO_010415,
   $sio:SIO_000614,
   $sio:SIO_000119,
   $sio:SIO_010416,
   $sio:SIO_010417,
   $sio:SIO_000616,
   $sio:SIO_010418,
   $sio:SIO_000617,
   $sio:SIO_010419,
   $sio:SIO_000618,
   $sio:SIO_000619,
   $sio:SIO_000070,
   $sio:SIO_000071,
   $sio:SIO_000072,
   $sio:SIO_000073,
   $sio:SIO_010370,
   $sio:SIO_000074,
   $sio:SIO_010371,
   $sio:SIO_001010,
   $sio:SIO_000570,
   $sio:SIO_000075,
   $sio:SIO_010372,
   $sio:SIO_001011,
   $sio:SIO_000571,
   $sio:SIO_000076,
   $sio:SIO_000120,
   $sio:SIO_010373,
   $sio:SIO_001012,
   $sio:SIO_000572,
   $sio:SIO_000077,
   $sio:SIO_000121,
   $sio:SIO_010374,
   $sio:SIO_001013,
   $sio:SIO_000573,
   $sio:SIO_000078,
   $sio:SIO_000122,
   $sio:SIO_010375,
   $sio:SIO_001014,
   $sio:SIO_000574,
   $sio:SIO_000079,
   $sio:SIO_000123,
   $sio:SIO_010420,
   $sio:SIO_010376,
   $sio:SIO_001015,
   $sio:SIO_000575,
   $sio:SIO_000124,
   $sio:SIO_010377,
   $sio:SIO_001016,
   $sio:SIO_000620,
   $sio:SIO_000576,
   $sio:SIO_000125,
   $sio:SIO_010378,
   $sio:SIO_001017,
   $sio:SIO_000621,
   $sio:SIO_000577,
   $sio:SIO_000126,
   $sio:SIO_010423,
   $sio:SIO_010379,
   $sio:SIO_001018,
   $sio:SIO_000622,
   $sio:SIO_000578,
   $sio:SIO_000127,
   $sio:SIO_010424,
   $sio:SIO_001019,
   $sio:SIO_000623,
   $sio:SIO_000579,
   $sio:SIO_000128,
   $sio:SIO_010425,
   $sio:SIO_000624,
   $sio:SIO_000129,
   $sio:SIO_010426,
   $sio:SIO_000625,
   $sio:SIO_010427,
   $sio:SIO_000626,
   $sio:SIO_010428,
   $sio:SIO_010429,
   $sio:SIO_000628,
   $sio:SIO_000629,
   $sio:SIO_000080,
   $sio:SIO_000081,
   $sio:SIO_000082,
   $sio:SIO_000083,
   $sio:SIO_001020,
   $sio:SIO_000580,
   $sio:SIO_000085,
   $sio:SIO_001021,
   $sio:SIO_000581,
   $sio:SIO_000130,
   $sio:SIO_010383,
   $sio:SIO_001022,
   $sio:SIO_000582,
   $sio:SIO_000087,
   $sio:SIO_000131,
   $sio:SIO_001023,
   $sio:SIO_000583,
   $sio:SIO_000088,
   $sio:SIO_000132,
   $sio:SIO_001024,
   $sio:SIO_000089,
   $sio:SIO_000133,
   $sio:SIO_010430,
   $sio:SIO_001025,
   $sio:SIO_000585,
   $sio:SIO_010431,
   $sio:SIO_001026,
   $sio:SIO_000630,
   $sio:SIO_000586,
   $sio:SIO_000135,
   $sio:SIO_010432,
   $sio:SIO_001027,
   $sio:SIO_000631,
   $sio:SIO_000587,
   $sio:SIO_000136,
   $sio:SIO_010433,
   $sio:SIO_001028,
   $sio:SIO_000632,
   $sio:SIO_000588,
   $sio:SIO_000137,
   $sio:SIO_010434,
   $sio:SIO_001029,
   $sio:SIO_000633,
   $sio:SIO_000589,
   $sio:SIO_000138,
   $sio:SIO_010435,
   $sio:SIO_000634,
   $sio:SIO_000139,
   $sio:SIO_010436,
   $sio:SIO_000635,
   $sio:SIO_010437,
   $sio:SIO_000636,
   $sio:SIO_010438,
   $sio:SIO_010439,
   $sio:SIO_000638,
   $sio:SIO_000639,
   $sio:SIO_000090,
   $sio:SIO_000091,
   $sio:SIO_000092,
   $sio:SIO_000093,
   $sio:SIO_000094,
   $sio:SIO_001030,
   $sio:SIO_000590,
   $sio:SIO_000095,
   $sio:SIO_001031,
   $sio:SIO_000591,
   $sio:SIO_000096,
   $sio:SIO_000140,
   $sio:SIO_001032,
   $sio:SIO_000592,
   $sio:SIO_000097,
   $sio:SIO_000141,
   $sio:SIO_001033,
   $sio:SIO_000593,
   $sio:SIO_000098,
   $sio:SIO_000142,
   $sio:SIO_001034,
   $sio:SIO_000594,
   $sio:SIO_000099,
   $sio:SIO_000143,
   $sio:SIO_010440,
   $sio:SIO_001035,
   $sio:SIO_000595,
   $sio:SIO_000144,
   $sio:SIO_010441,
   $sio:SIO_001036,
   $sio:SIO_000640,
   $sio:SIO_000596,
   $sio:SIO_000145,
   $sio:SIO_010442,
   $sio:SIO_001037,
   $sio:SIO_000641,
   $sio:SIO_000597,
   $sio:SIO_000146,
   $sio:SIO_010443,
   $sio:SIO_001038,
   $sio:SIO_000642,
   $sio:SIO_000598,
   $sio:SIO_000147,
   $sio:SIO_010444,
   $sio:SIO_001039,
   $sio:SIO_000643,
   $sio:SIO_000148,
   $sio:SIO_010445,
   $sio:SIO_000644,
   $sio:SIO_010446,
   $sio:SIO_010447,
   $sio:SIO_000646,
   $sio:SIO_010448,
   $sio:SIO_000647,
   $sio:SIO_000648,
   $sio:SIO_000649,
   $sio:SIO_001040,
   $sio:SIO_001041,
   $sio:SIO_000150,
   $sio:SIO_001042,
   $sio:SIO_000151,
   $sio:SIO_001043,
   $sio:SIO_000152,
   $sio:SIO_001044,
   $sio:SIO_000153,
   $sio:SIO_010450,
   $sio:SIO_001045,
   $sio:SIO_000154,
   $sio:SIO_010451,
   $sio:SIO_010000,
   $sio:SIO_001046,
   $sio:SIO_000650,
   $sio:SIO_000155,
   $sio:SIO_010452,
   $sio:SIO_010001,
   $sio:SIO_001047,
   $sio:SIO_000651,
   $sio:SIO_000156,
   $sio:SIO_000200,
   $sio:SIO_010453,
   $sio:SIO_010002,
   $sio:SIO_001048,
   $sio:SIO_000652,
   $sio:SIO_000157,
   $sio:SIO_000201,
   $sio:SIO_010454,
   $sio:SIO_010003,
   $sio:SIO_001049,
   $sio:SIO_000653,
   $sio:SIO_000158,
   $sio:SIO_000202,
   $sio:SIO_010455,
   $sio:SIO_010004,
   $sio:SIO_000654,
   $sio:SIO_000159,
   $sio:SIO_000203,
   $sio:SIO_010500,
   $sio:SIO_010456,
   $sio:SIO_010005,
   $sio:SIO_000655,
   $sio:SIO_000204,
   $sio:SIO_010501,
   $sio:SIO_010457,
   $sio:SIO_000700,
   $sio:SIO_000656,
   $sio:SIO_000205,
   $sio:SIO_010502,
   $sio:SIO_010458,
   $sio:SIO_010007,
   $sio:SIO_000701,
   $sio:SIO_000657,
   $sio:SIO_000206,
   $sio:SIO_010503,
   $sio:SIO_010459,
   $sio:SIO_010008,
   $sio:SIO_000702,
   $sio:SIO_000658,
   $sio:SIO_000207,
   $sio:SIO_010504,
   $sio:SIO_010009,
   $sio:SIO_000703,
   $sio:SIO_000208,
   $sio:SIO_010505,
   $sio:SIO_000704,
   $sio:SIO_000209,
   $sio:SIO_010506,
   $sio:SIO_000705,
   $sio:SIO_010507,
   $sio:SIO_000706,
   $sio:SIO_010508,
   $sio:SIO_000707,
   $sio:SIO_010509,
   $sio:SIO_000708,
   $sio:SIO_000709,
   $sio:SIO_001050,
   $sio:SIO_001051,
   $sio:SIO_000160,
   $sio:SIO_001052,
   $sio:SIO_000161,
   $sio:SIO_001053,
   $sio:SIO_000162,
   $sio:SIO_001054,
   $sio:SIO_000163,
   $sio:SIO_010460,
   $sio:SIO_001055,
   $sio:SIO_000164,
   $sio:SIO_010461,
   $sio:SIO_010010,
   $sio:SIO_001100,
   $sio:SIO_001056,
   $sio:SIO_000660,
   $sio:SIO_000165,
   $sio:SIO_010462,
   $sio:SIO_010011,
   $sio:SIO_001101,
   $sio:SIO_001057,
   $sio:SIO_000661,
   $sio:SIO_000166,
   $sio:SIO_000210,
   $sio:SIO_010463,
   $sio:SIO_001102,
   $sio:SIO_001058,
   $sio:SIO_000662,
   $sio:SIO_000167,
   $sio:SIO_000211,
   $sio:SIO_010464,
   $sio:SIO_010013,
   $sio:SIO_001103,
   $sio:SIO_001059,
   $sio:SIO_000663,
   $sio:SIO_000168,
   $sio:SIO_000212,
   $sio:SIO_010465,
   $sio:SIO_010014,
   $sio:SIO_001104,
   $sio:SIO_000664,
   $sio:SIO_000169,
   $sio:SIO_000213,
   $sio:SIO_010510,
   $sio:SIO_010015,
   $sio:SIO_001105,
   $sio:SIO_000665,
   $sio:SIO_000214,
   $sio:SIO_010511,
   $sio:SIO_010016,
   $sio:SIO_001106,
   $sio:SIO_000710,
   $sio:SIO_000666,
   $sio:SIO_000215,
   $sio:SIO_010512,
   $sio:SIO_010468,
   $sio:SIO_010017,
   $sio:SIO_001107,
   $sio:SIO_000711,
   $sio:SIO_000667,
   $sio:SIO_000216,
   $sio:SIO_010513,
   $sio:SIO_010469,
   $sio:SIO_010018,
   $sio:SIO_001108,
   $sio:SIO_000712,
   $sio:SIO_000668,
   $sio:SIO_000217,
   $sio:SIO_010514,
   $sio:SIO_010019,
   $sio:SIO_001109,
   $sio:SIO_000713,
   $sio:SIO_000669,
   $sio:SIO_000218,
   $sio:SIO_010515,
   $sio:SIO_000714,
   $sio:SIO_000219,
   $sio:SIO_010516,
   $sio:SIO_000715,
   $sio:SIO_010517,
   $sio:SIO_000716,
   $sio:SIO_010518,
   $sio:SIO_000717,
   $sio:SIO_010519,
   $sio:SIO_000719,
   $sio:SIO_001060,
   $sio:SIO_001061,
   $sio:SIO_000170,
   $sio:SIO_001062,
   $sio:SIO_000171,
   $sio:SIO_001063,
   $sio:SIO_000172,
   $sio:SIO_001064,
   $sio:SIO_000173,
   $sio:SIO_001065,
   $sio:SIO_000174,
   $sio:SIO_010471,
   $sio:SIO_010020,
   $sio:SIO_001110,
   $sio:SIO_001066,
   $sio:SIO_000670,
   $sio:SIO_000175,
   $sio:SIO_001111,
   $sio:SIO_001067,
   $sio:SIO_000671,
   $sio:SIO_000176,
   $sio:SIO_000220,
   $sio:SIO_010022,
   $sio:SIO_001112,
   $sio:SIO_001068,
   $sio:SIO_000672,
   $sio:SIO_000177,
   $sio:SIO_000221,
   $sio:SIO_010023,
   $sio:SIO_001113,
   $sio:SIO_001069,
   $sio:SIO_000673,
   $sio:SIO_000178,
   $sio:SIO_000222,
   $sio:SIO_010024,
   $sio:SIO_001114,
   $sio:SIO_000674,
   $sio:SIO_000179,
   $sio:SIO_000223,
   $sio:SIO_010520,
   $sio:SIO_010025,
   $sio:SIO_001115,
   $sio:SIO_000675,
   $sio:SIO_000224,
   $sio:SIO_010521,
   $sio:SIO_010026,
   $sio:SIO_001116,
   $sio:SIO_000720,
   $sio:SIO_000676,
   $sio:SIO_000225,
   $sio:SIO_010522,
   $sio:SIO_010027,
   $sio:SIO_001117,
   $sio:SIO_000721,
   $sio:SIO_000677,
   $sio:SIO_000226,
   $sio:SIO_010523,
   $sio:SIO_010028,
   $sio:SIO_001118,
   $sio:SIO_000722,
   $sio:SIO_000678,
   $sio:SIO_000227,
   $sio:SIO_010029,
   $sio:SIO_001119,
   $sio:SIO_000723,
   $sio:SIO_000679,
   $sio:SIO_000228,
   $sio:SIO_010525,
   $sio:SIO_000724,
   $sio:SIO_000229,
   $sio:SIO_010526,
   $sio:SIO_000725,
   $sio:SIO_010527,
   $sio:SIO_000726,
   $sio:SIO_010528,
   $sio:SIO_000727,
   $sio:SIO_000728,
   $sio:SIO_000729,
   $sio:SIO_001070,
   $sio:SIO_001071,
   $sio:SIO_000180,
   $sio:SIO_001072,
   $sio:SIO_000181,
   $sio:SIO_001073,
   $sio:SIO_000182,
   $sio:SIO_001074,
   $sio:SIO_000183,
   $sio:SIO_001075,
   $sio:SIO_000184,
   $sio:SIO_010030,
   $sio:SIO_001120,
   $sio:SIO_001076,
   $sio:SIO_000680,
   $sio:SIO_000185,
   $sio:SIO_010031,
   $sio:SIO_001121,
   $sio:SIO_001077,
   $sio:SIO_000681,
   $sio:SIO_000186,
   $sio:SIO_000230,
   $sio:SIO_010032,
   $sio:SIO_001122,
   $sio:SIO_001078,
   $sio:SIO_000682,
   $sio:SIO_000231,
   $sio:SIO_010033,
   $sio:SIO_001123,
   $sio:SIO_001079,
   $sio:SIO_000683,
   $sio:SIO_000188,
   $sio:SIO_000232,
   $sio:SIO_010034,
   $sio:SIO_001124,
   $sio:SIO_000684,
   $sio:SIO_000189,
   $sio:SIO_000233,
   $sio:SIO_010530,
   $sio:SIO_010035,
   $sio:SIO_001125,
   $sio:SIO_000234,
   $sio:SIO_010531,
   $sio:SIO_010036,
   $sio:SIO_001126,
   $sio:SIO_000730,
   $sio:SIO_000686,
   $sio:SIO_000235,
   $sio:SIO_010532,
   $sio:SIO_010037,
   $sio:SIO_001127,
   $sio:SIO_000731,
   $sio:SIO_000687,
   $sio:SIO_000236,
   $sio:SIO_010533,
   $sio:SIO_010038,
   $sio:SIO_001128,
   $sio:SIO_000732,
   $sio:SIO_000688,
   $sio:SIO_000237,
   $sio:SIO_010039,
   $sio:SIO_001129,
   $sio:SIO_000733,
   $sio:SIO_000689,
   $sio:SIO_000238,
   $sio:SIO_000734,
   $sio:SIO_000239,
   $sio:SIO_000735,
   $sio:SIO_000736,
   $sio:SIO_000737,
   $sio:SIO_000738,
   $sio:SIO_000739,
   $sio:SIO_001080,
   $sio:SIO_001081,
   $sio:SIO_000190,
   $sio:SIO_001082,
   $sio:SIO_000191,
   $sio:SIO_001083,
   $sio:SIO_000192,
   $sio:SIO_001084,
   $sio:SIO_000193,
   $sio:SIO_001085,
   $sio:SIO_000194,
   $sio:SIO_010040,
   $sio:SIO_001130,
   $sio:SIO_001086,
   $sio:SIO_000690,
   $sio:SIO_000195,
   $sio:SIO_010041,
   $sio:SIO_001131,
   $sio:SIO_001087,
   $sio:SIO_000196,
   $sio:SIO_000240,
   $sio:SIO_010042,
   $sio:SIO_001132,
   $sio:SIO_001088,
   $sio:SIO_000692,
   $sio:SIO_000197,
   $sio:SIO_000241,
   $sio:SIO_010043,
   $sio:SIO_001133,
   $sio:SIO_001089,
   $sio:SIO_000693,
   $sio:SIO_000198,
   $sio:SIO_000242,
   $sio:SIO_010044,
   $sio:SIO_001134,
   $sio:SIO_000694,
   $sio:SIO_000199,
   $sio:SIO_000243,
   $sio:SIO_010496,
   $sio:SIO_010045,
   $sio:SIO_001135,
   $sio:SIO_000695,
   $sio:SIO_000244,
   $sio:SIO_010497,
   $sio:SIO_010046,
   $sio:SIO_001136,
   $sio:SIO_000740,
   $sio:SIO_000696,
   $sio:SIO_000245,
   $sio:SIO_010498,
   $sio:SIO_010047,
   $sio:SIO_001137,
   $sio:SIO_000741,
   $sio:SIO_000697,
   $sio:SIO_000246,
   $sio:SIO_010499,
   $sio:SIO_010048,
   $sio:SIO_001138,
   $sio:SIO_000742,
   $sio:SIO_000698,
   $sio:SIO_000247,
   $sio:SIO_010049,
   $sio:SIO_001139,
   $sio:SIO_000743,
   $sio:SIO_000699,
   $sio:SIO_000248,
   $sio:SIO_000744,
   $sio:SIO_000249,
   $sio:SIO_000745,
   $sio:SIO_000746,
   $sio:SIO_000747,
   $sio:SIO_000748,
   $sio:SIO_000749,
   $sio:SIO_001090,
   $sio:SIO_001091,
   $sio:SIO_001092,
   $sio:SIO_001093,
   $sio:SIO_001094,
   $sio:SIO_001095,
   $sio:SIO_010050,
   $sio:SIO_001140,
   $sio:SIO_001096,
   $sio:SIO_010051,
   $sio:SIO_001141,
   $sio:SIO_001097,
   $sio:SIO_000250,
   $sio:SIO_010052,
   $sio:SIO_001142,
   $sio:SIO_001098,
   $sio:SIO_000251,
   $sio:SIO_010053,
   $sio:SIO_001143,
   $sio:SIO_001099,
   $sio:SIO_000252,
   $sio:SIO_010054,
   $sio:SIO_001144,
   $sio:SIO_000253,
   $sio:SIO_010055,
   $sio:SIO_001145,
   $sio:SIO_000254,
   $sio:SIO_010100,
   $sio:SIO_010056,
   $sio:SIO_001146,
   $sio:SIO_000750,
   $sio:SIO_000255,
   $sio:SIO_010101,
   $sio:SIO_010057,
   $sio:SIO_001147,
   $sio:SIO_000751,
   $sio:SIO_000256,
   $sio:SIO_000300,
   $sio:SIO_010058,
   $sio:SIO_001148,
   $sio:SIO_000752,
   $sio:SIO_000257,
   $sio:SIO_000301,
   $sio:SIO_010059,
   $sio:SIO_001149,
   $sio:SIO_000753,
   $sio:SIO_000258,
   $sio:SIO_000302,
   $sio:SIO_000754,
   $sio:SIO_000259,
   $sio:SIO_000755,
   $sio:SIO_000304,
   $sio:SIO_000800,
   $sio:SIO_000756,
   $sio:SIO_000305,
   $sio:SIO_000801,
   $sio:SIO_000757,
   $sio:SIO_000306,
   $sio:SIO_000802,
   $sio:SIO_000758,
   $sio:SIO_000307,
   $sio:SIO_000803,
   $sio:SIO_000759,
   $sio:SIO_000308,
   $sio:SIO_000804,
   $sio:SIO_000309,
   $sio:SIO_000805,
   $sio:SIO_000806,
   $sio:SIO_000807,
   $sio:SIO_000808,
   $sio:SIO_000809,
   $sio:SIO_010060,
   $sio:SIO_001150,
   $sio:SIO_010061,
   $sio:SIO_001151,
   $sio:SIO_001152,
   $sio:SIO_000261,
   $sio:SIO_001153,
   $sio:SIO_000262,
   $sio:SIO_010064,
   $sio:SIO_001154,
   $sio:SIO_000263,
   $sio:SIO_011000,
   $sio:SIO_010065,
   $sio:SIO_001155,
   $sio:SIO_000264,
   $sio:SIO_011001,
   $sio:SIO_010066,
   $sio:SIO_001156,
   $sio:SIO_000760,
   $sio:SIO_000265,
   $sio:SIO_011002,
   $sio:SIO_010067,
   $sio:SIO_001157,
   $sio:SIO_000761,
   $sio:SIO_000266,
   $sio:SIO_000310,
   $sio:SIO_011003,
   $sio:SIO_010068,
   $sio:SIO_001158,
   $sio:SIO_000762,
   $sio:SIO_000267,
   $sio:SIO_000311,
   $sio:SIO_011004,
   $sio:SIO_001159,
   $sio:SIO_000763,
   $sio:SIO_000268,
   $sio:SIO_000312,
   $sio:SIO_011005,
   $sio:SIO_000764,
   $sio:SIO_000269,
   $sio:SIO_000313,
   $sio:SIO_011006,
   $sio:SIO_000765,
   $sio:SIO_000314,
   $sio:SIO_011007,
   $sio:SIO_000810,
   $sio:SIO_000766,
   $sio:SIO_000315,
   $sio:SIO_011008,
   $sio:SIO_000811,
   $sio:SIO_000767,
   $sio:SIO_000316,
   $sio:SIO_011009,
   $sio:SIO_000812,
   $sio:SIO_000768,
   $sio:SIO_000317,
   $sio:SIO_000813,
   $sio:SIO_000769,
   $sio:SIO_000318,
   $sio:SIO_000814,
   $sio:SIO_000319,
   $sio:SIO_000815,
   $sio:SIO_000816,
   $sio:SIO_000817,
   $sio:SIO_000818,
   $sio:SIO_000819,
   $sio:SIO_010070,
   $sio:SIO_001160,
   $sio:SIO_010071,
   $sio:SIO_001161,
   $sio:SIO_000270,
   $sio:SIO_010072,
   $sio:SIO_001162,
   $sio:SIO_010073,
   $sio:SIO_001163,
   $sio:SIO_000272,
   $sio:SIO_010074,
   $sio:SIO_001164,
   $sio:SIO_000273,
   $sio:SIO_011010,
   $sio:SIO_010075,
   $sio:SIO_001165,
   $sio:SIO_000274,
   $sio:SIO_011011,
   $sio:SIO_010076,
   $sio:SIO_001166,
   $sio:SIO_000770,
   $sio:SIO_000275,
   $sio:SIO_011012,
   $sio:SIO_010077,
   $sio:SIO_001167,
   $sio:SIO_000771,
   $sio:SIO_000276,
   $sio:SIO_000320,
   $sio:SIO_011013,
   $sio:SIO_010078,
   $sio:SIO_001168,
   $sio:SIO_000772,
   $sio:SIO_000277,
   $sio:SIO_000321,
   $sio:SIO_011014,
   $sio:SIO_010079,
   $sio:SIO_001169,
   $sio:SIO_000773,
   $sio:SIO_000278,
   $sio:SIO_000322,
   $sio:SIO_011015,
   $sio:SIO_000774,
   $sio:SIO_000279,
   $sio:SIO_000323,
   $sio:SIO_011016,
   $sio:SIO_000775,
   $sio:SIO_000324,
   $sio:SIO_011017,
   $sio:SIO_000820,
   $sio:SIO_000776,
   $sio:SIO_000325,
   $sio:SIO_011018,
   $sio:SIO_000821,
   $sio:SIO_000777,
   $sio:SIO_000326,
   $sio:SIO_011019,
   $sio:SIO_000822,
   $sio:SIO_000778,
   $sio:SIO_000327,
   $sio:SIO_000823,
   $sio:SIO_000779,
   $sio:SIO_000328,
   $sio:SIO_000824,
   $sio:SIO_000329,
   $sio:SIO_000825,
   $sio:SIO_000826,
   $sio:SIO_000827,
   $sio:SIO_000828,
   $sio:SIO_000829,
   $sio:SIO_010080,
   $sio:SIO_001170,
   $sio:SIO_010081,
   $sio:SIO_001171,
   $sio:SIO_000280,
   $sio:SIO_010082,
   $sio:SIO_001172,
   $sio:SIO_000281,
   $sio:SIO_010083,
   $sio:SIO_001173,
   $sio:SIO_000282,
   $sio:SIO_010084,
   $sio:SIO_001174,
   $sio:SIO_000283,
   $sio:SIO_011020,
   $sio:SIO_010085,
   $sio:SIO_001175,
   $sio:SIO_000284,
   $sio:SIO_011021,
   $sio:SIO_010086,
   $sio:SIO_001176,
   $sio:SIO_000780,
   $sio:SIO_000285,
   $sio:SIO_011022,
   $sio:SIO_010087,
   $sio:SIO_001177,
   $sio:SIO_000286,
   $sio:SIO_000330,
   $sio:SIO_011023,
   $sio:SIO_010088,
   $sio:SIO_001178,
   $sio:SIO_000287,
   $sio:SIO_000331,
   $sio:SIO_011024,
   $sio:SIO_010089,
   $sio:SIO_001179,
   $sio:SIO_000783,
   $sio:SIO_000288,
   $sio:SIO_000332,
   $sio:SIO_011025,
   $sio:SIO_000784,
   $sio:SIO_000289,
   $sio:SIO_000333,
   $sio:SIO_011026,
   $sio:SIO_000785,
   $sio:SIO_000334,
   $sio:SIO_011027,
   $sio:SIO_000830,
   $sio:SIO_000786,
   $sio:SIO_000335,
   $sio:SIO_011028,
   $sio:SIO_000831,
   $sio:SIO_000787,
   $sio:SIO_011029,
   $sio:SIO_000832,
   $sio:SIO_000788,
   $sio:SIO_000337,
   $sio:SIO_000833,
   $sio:SIO_000789,
   $sio:SIO_000338,
   $sio:SIO_000834,
   $sio:SIO_000339,
   $sio:SIO_000835,
   $sio:SIO_000836,
   $sio:SIO_000837,
   $sio:SIO_000838,
   $sio:SIO_000839,
   $sio:SIO_010090,
   $sio:SIO_001180,
   $sio:SIO_010091,
   $sio:SIO_001181,
   $sio:SIO_000290,
   $sio:SIO_010092,
   $sio:SIO_001182,
   $sio:SIO_000291,
   $sio:SIO_010093,
   $sio:SIO_001183,
   $sio:SIO_000292,
   $sio:SIO_010094,
   $sio:SIO_001184,
   $sio:SIO_000293,
   $sio:SIO_011030,
   $sio:SIO_010095,
   $sio:SIO_001185,
   $sio:SIO_000294,
   $sio:SIO_011031,
   $sio:SIO_010096,
   $sio:SIO_000790,
   $sio:SIO_000295,
   $sio:SIO_011032,
   $sio:SIO_010097,
   $sio:SIO_000791,
   $sio:SIO_000296,
   $sio:SIO_000340,
   $sio:SIO_011033,
   $sio:SIO_010098,
   $sio:SIO_000792,
   $sio:SIO_000297,
   $sio:SIO_000341,
   $sio:SIO_011034,
   $sio:SIO_010099,
   $sio:SIO_000793,
   $sio:SIO_000298,
   $sio:SIO_000342,
   $sio:SIO_011035,
   $sio:SIO_000794,
   $sio:SIO_000299,
   $sio:SIO_000343,
   $sio:SIO_011036,
   $sio:SIO_000795,
   $sio:SIO_000344,
   $sio:SIO_011037,
   $sio:SIO_000840,
   $sio:SIO_000796,
   $sio:SIO_000345,
   $sio:SIO_011038,
   $sio:SIO_000841,
   $sio:SIO_000797,
   $sio:SIO_000346,
   $sio:SIO_011039,
   $sio:SIO_000842,
   $sio:SIO_000798,
   $sio:SIO_000347,
   $sio:SIO_000843,
   $sio:SIO_000799,
   $sio:SIO_000348,
   $sio:SIO_000844,
   $sio:SIO_000349,
   $sio:SIO_000845,
   $sio:SIO_000846,
   $sio:SIO_000847,
   $sio:SIO_000848,
   $sio:SIO_000849,
   $sio:SIO_011040,
   $sio:SIO_011041,
   $sio:SIO_011042,
   $sio:SIO_000350,
   $sio:SIO_011043,
   $sio:SIO_000351,
   $sio:SIO_011044,
   $sio:SIO_000352,
   $sio:SIO_011045,
   $sio:SIO_000353,
   $sio:SIO_011046,
   $sio:SIO_000354,
   $sio:SIO_011047,
   $sio:SIO_000850,
   $sio:SIO_000355,
   $sio:SIO_011048,
   $sio:SIO_000851,
   $sio:SIO_000356,
   $sio:SIO_000400,
   $sio:SIO_011049,
   $sio:SIO_000852,
   $sio:SIO_000357,
   $sio:SIO_000401,
   $sio:SIO_000853,
   $sio:SIO_000358,
   $sio:SIO_000402,
   $sio:SIO_000854,
   $sio:SIO_000359,
   $sio:SIO_000403,
   $sio:SIO_000855,
   $sio:SIO_000404,
   $sio:SIO_000900,
   $sio:SIO_000856,
   $sio:SIO_000405,
   $sio:SIO_000901,
   $sio:SIO_000857,
   $sio:SIO_000406,
   $sio:SIO_000902,
   $sio:SIO_000858,
   $sio:SIO_000407,
   $sio:SIO_000903,
   $sio:SIO_000859,
   $sio:SIO_000408,
   $sio:SIO_000904,
   $sio:SIO_000409,
   $sio:SIO_000905,
   $sio:SIO_000906,
   $sio:SIO_000907,
   $sio:SIO_000908,
   $sio:SIO_000909,
   $sio:SIO_011050,
   $sio:SIO_011051,
   $sio:SIO_011052,
   $sio:SIO_000360,
   $sio:SIO_011053,
   $sio:SIO_011054,
   $sio:SIO_000362,
   $sio:SIO_011055,
   $sio:SIO_000363,
   $sio:SIO_011100,
   $sio:SIO_011056,
   $sio:SIO_000364,
   $sio:SIO_011101,
   $sio:SIO_011057,
   $sio:SIO_000860,
   $sio:SIO_000365,
   $sio:SIO_011102,
   $sio:SIO_011058,
   $sio:SIO_000861,
   $sio:SIO_000366,
   $sio:SIO_000410,
   $sio:SIO_011103,
   $sio:SIO_011059,
   $sio:SIO_000862,
   $sio:SIO_000367,
   $sio:SIO_000411,
   $sio:SIO_011104,
   $sio:SIO_000863,
   $sio:SIO_000368,
   $sio:SIO_000412,
   $sio:SIO_011105,
   $sio:SIO_000864,
   $sio:SIO_000369,
   $sio:SIO_000413,
   $sio:SIO_011106,
   $sio:SIO_000865,
   $sio:SIO_000414,
   $sio:SIO_011107,
   $sio:SIO_000910,
   $sio:SIO_000866,
   $sio:SIO_000415,
   $sio:SIO_011108,
   $sio:SIO_000911,
   $sio:SIO_000867,
   $sio:SIO_011109,
   $sio:SIO_000912,
   $sio:SIO_000868,
   $sio:SIO_000417,
   $sio:SIO_000913,
   $sio:SIO_000869,
   $sio:SIO_000418,
   $sio:SIO_000914,
   $sio:SIO_000419,
   $sio:SIO_000915,
   $sio:SIO_000916,
   $sio:SIO_000917,
   $sio:SIO_000918,
   $sio:SIO_000919
)"/>

</xsl:transform>
