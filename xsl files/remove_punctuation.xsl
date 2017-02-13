<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    
    <xsl:template match="treebank">
        <treebank>
            <xsl:copy-of select="@*"/>
            
            <xsl:for-each select="sentence">
                <sentence>
                    <xsl:copy-of select="@*"/>
                    <xsl:for-each select="word">
                        <xsl:choose>
                            <xsl:when test="./@relation = 'AuxX'"></xsl:when>
                            <xsl:when test="./@relation = 'AuxK'"></xsl:when>
                            <xsl:when test="./@relation = 'AuxG'"></xsl:when>
                            <xsl:otherwise>
                                <word>
                                    <xsl:copy-of select="@*"/> 
                                </word>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </sentence>
                    
            </xsl:for-each>
                
        </treebank>
        
        
    </xsl:template>
</xsl:stylesheet>