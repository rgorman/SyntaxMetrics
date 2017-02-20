<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="sentence">
        <xsl:variable name="reference">
            <xsl:value-of select="//comment"/>
        </xsl:variable>
        <sentence>
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="reference">
                <xsl:value-of select="$reference"/>: s-<xsl:value-of select="./@id"/>
            </xsl:attribute>
            
            <xsl:for-each select="word">
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </sentence>
        
    </xsl:template>
    
    
   
    
</xsl:stylesheet>