<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="html" encoding="UTF-8" indent="yes" />
  
  <xsl:template match="/">
    <html>
      <head>
	<title>検索ページ</title>
      </head>
      <body>
	<h1>書籍検索ページ</h1>
	<form action="search.cgi" method="get">
	  検索ワード:<input type="text" name="query" ><xsl:attribute name="value"><xsl:value-of select="$query" /></xsl:attribute></input><br />
		<input type="submit" value="検索" /><br />
		検索対象：<br />
		<input type="checkbox" name="title" ><xsl:if test="$title = 'on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input>タイトル
		<input type="checkbox" name="creator" ><xsl:if test="$creator = 'on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input>作者
		<input type="checkbox" name="publisher" ><xsl:if test="$publisher = 'on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input>出版日
		<input type="checkbox" name="price" ><xsl:if test="$price = 'on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input>価格
		<input type="checkbox" name="isbn" ><xsl:if test="$isbn = 'on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input>isbn
		<input type="checkbox" name="url" ><xsl:if test="$url = 'on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input>URL
		<input type="checkbox" name="description" ><xsl:if test="$description = 'on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input>概要
		<input type="checkbox" name="keyword" ><xsl:if test="$keyword = 'on'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input>キーワード<br />
		並び順：<br />
		<input type="radio" name="order" value="price_down"><xsl:if test="$order = 'price_down' or $order != 'price_up' and $order != 'date_up' and $order != 'date_down' "><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input>価格降順
		<input type="radio" name="order" value="price_up"><xsl:if test="$order = 'price_up'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input>価格昇順
		<input type="radio" name="order" value="date_down"><xsl:if test="$order = 'date_down'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input>出版日降順
		<input type="radio" name="order" value="date_up"><xsl:if test="$order = 'date_up'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input>出版日昇順
	</form>
        <xsl:if test="$search = 'true'">
      	  <xsl:apply-templates select="books" />
	</xsl:if>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="books">
    <table border='1'>
      <tr><th>タイトル</th><th>作者</th><th>出版日</th><th>価格(円)</th></tr>
      <xsl:choose>
	<xsl:when test="$order = 'price_down'">
     	  <xsl:for-each select="item">
	    <xsl:sort select="price" data-type="number" order="descending" />
	    <xsl:apply-templates select="." />
	  </xsl:for-each>
	</xsl:when>
	<xsl:when test="$order = 'price_up'">
     	  <xsl:for-each select="item">
	    <xsl:sort select="price" data-type="number" order="ascending" />
	    <xsl:apply-templates select="." />
     	  </xsl:for-each>
	</xsl:when>
	<xsl:when test="$order = 'date_down'">
     	  <xsl:for-each select="item">
	    <xsl:sort select="date/year" data-type="number" order="descending" />
	    <xsl:sort select="date/month" data-type="number" order="descending" />
	    <xsl:sort select="date/day" data-type="number" order="descending" />
	    <xsl:apply-templates select="." />
     	  </xsl:for-each>
	</xsl:when>
	<xsl:when test="$order = 'date_up'">
     	  <xsl:for-each select="item">
	    <xsl:sort select="date/year" data-type="number" order="ascending" />
	    <xsl:sort select="date/month" data-type="number" order="ascending" />
	    <xsl:sort select="date/day" data-type="number" order="ascending" />
	    <xsl:apply-templates select="." />
     	  </xsl:for-each>
	</xsl:when>
      </xsl:choose>
    </table>
  </xsl:template>
  
  <xsl:template match="item">
    <xsl:if test="$title = 'on' and contains(title,$query) or $creator = 'on' and contains(creator,$query) or  $publisher = 'on' and contains(publisher,$query) or $price = 'on' and contains(price,$query) or $isbn = 'on' and contains(isbn,$query) or $url = 'on' and contains(url/@resource,$query) or $description = 'on' and contains(description,$query) or  $keyword = 'on' and (contains(keywords/keyword[1],$query) or contains(keywords/keyword[2],$query) or contains(keywords/keyword[3],$query))">
      <tr>
	<td><a><xsl:attribute name="href">details.cgi?number=<xsl:value-of select="@no" /></xsl:attribute><xsl:value-of select="title" /></a></td>
	<td><xsl:value-of select="creator" /></td>
	<td><xsl:value-of select="date/year" />-<xsl:value-of select="date/month" />-<xsl:value-of select="date/day" /></td>
	<td><xsl:value-of select="price" /></td>
      </tr>
    </xsl:if>	
  </xsl:template>
  
</xsl:stylesheet>
