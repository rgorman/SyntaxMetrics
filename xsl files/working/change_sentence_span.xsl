<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="sentence">
        <sentence>
            <xsl:attribute name="new_id">
                <xsl:value-of><xsl:number/></xsl:value-of>
            </xsl:attribute>
            <xsl:copy-of select="@*"/>
            <xsl:for-each select="word">
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </sentence>
        
    </xsl:template>
    
</xsl:stylesheet>