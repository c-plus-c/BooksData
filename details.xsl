<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="html" encoding="UTF-8" indent="yes" />
  
  <xsl:template match="/">
    <html>
	<head>
		<title>詳細ページ</title>
	</head>
	<body>
	<h1>詳細ページ</h1>
      	    <xsl:apply-templates select="books/item[@no = $number]" />
	</body>
    </html>
  </xsl:template>
  
  <xsl:template match="item">
	タイトル:<xsl:value-of select="title"/><br/>
	作者:<xsl:value-of select="creator"/><br/>
	出版社:<xsl:value-of select="publisher"/><br/>
	価格:<xsl:value-of select="price"/><br/>
	日付:<xsl:value-of select="date/year"/>/<xsl:value-of select="date/month"/>/<xsl:value-of select="date/day"/><br/>
	ISBN:<xsl:value-of select="isbn"/><br/>
	URL:<a><xsl:attribute name="href"><xsl:value-of select="url/@resource"/></xsl:attribute>詳細へのリンクへ</a><br/>
	概要:<xsl:value-of select="description"/><br/>
	キーワード1:<xsl:value-of select="keywords/keyword[1]"/><br/>
	キーワード2:<xsl:value-of select="keywords/keyword[2]"/><br/>
	キーワード3:<xsl:value-of select="keywords/keyword[3]"/><br/>
  </xsl:template>
  
</xsl:stylesheet>
