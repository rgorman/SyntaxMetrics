<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
  
    <xsl:template match="projectivity_document">
        <projectivity_document>
            <xsl:for-each select="sentence">
                <sentence>
                    <xsl:copy-of select="@*"/>
                    <xsl:attribute name="combined">
                        <xsl:value-of select="./word/geodesic"/>
                    </xsl:attribute>
                    <xsl:for-each select="./word">
                        <xsl:copy-of select="."></xsl:copy-of>
                    </xsl:for-each>
                </sentence>
                
                
                
            </xsl:for-each>
            
        </projectivity_document>
        
    </xsl:template>    
  
    
    
</xsl:stylesheet>