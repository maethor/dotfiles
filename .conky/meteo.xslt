<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" >
        <xsl:output method="text" disable-output-escaping="yes"/>
        <xsl:template match="weather">
        	<xsl:text>Ville : </xsl:text><xsl:value-of select="/weather/loc/dnam"/>
                <xsl:apply-templates select="cc"/>
                <xsl:apply-templates select="dayf/day[@d='1']"/>
                <xsl:text>
Lever du soleil : </xsl:text><xsl:value-of select="/weather/loc/sunr"/>
		<xsl:text>
Coucher du soleil : </xsl:text><xsl:value-of select="/weather/loc/suns"/>
        </xsl:template>

        <xsl:template match="cc">
<xsl:text>
Température aujourd'hui : </xsl:text><xsl:value-of select="tmp"/>°<xsl:value-of select="/weather/head/ut"/>
<xsl:if test="tmp != flik">
<xsl:text> (</xsl:text>
<xsl:value-of select="flik"/>°<xsl:value-of select="/weather/head/ut"/>
<xsl:text> ressenti)</xsl:text>
</xsl:if>
<xsl:text>
Conditions aujourd'hui : </xsl:text><xsl:value-of select="t"/>
<xsl:text>
Vent aujourd'hui : </xsl:text>
<xsl:choose>
<xsl:when test="wind/s = 'calm'"><xsl:text>0</xsl:text></xsl:when>
<xsl:otherwise><xsl:value-of select="wind/s"/></xsl:otherwise>
</xsl:choose>
<xsl:text> </xsl:text>
<xsl:value-of select="/weather/head/us"/>
</xsl:template>

<xsl:template match="dayf/day[@d='1']">
<xsl:text>
Température demain : de </xsl:text><xsl:value-of select="low"/>°<xsl:value-of select="/weather/head/ut"/>
<xsl:text> à </xsl:text><xsl:value-of select="hi"/>°<xsl:value-of select="/weather/head/ut"/>
<xsl:text>
Conditions demain : </xsl:text><xsl:value-of select="part[@p='d']/t"/>
</xsl:template>
</xsl:stylesheet>
