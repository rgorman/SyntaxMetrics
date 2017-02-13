<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    
    <xsl:template match="sWord_document">
        <sWord_document>
            
            <xsl:for-each select="comment">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            <xsl:for-each select="annotator">
                <xsl:copy-of select="."/>
            </xsl:for-each>
            
          <xsl:for-each select="sentence">
              <sentence>
                  <xsl:copy-of select="@*"/>
                  <xsl:for-each select="word">
                      <xsl:variable name="word_count" select="count(../word)"/>
                      <xsl:variable name="self_id" select="./@id"/>
                <word>
                         <xsl:copy-of select="@*"/>
                      <xsl:copy-of select="child::node()"></xsl:copy-of>
                         <xsl:choose>
                             <xsl:when test="./@id=$word_count"></xsl:when>
                             <xsl:otherwise>
                                 <xsl:choose>
                                     <xsl:when test="$self_id=1">
                                         <bigram-rel-pos-sWordLevel-0>start=<xsl:value-of select="./rel-pos-sWord-0"/></bigram-rel-pos-sWordLevel-0>
                                         <bigram-rel-pos-sWordLevel-0><xsl:value-of select="./rel-pos-sWord-0"/>=<xsl:value-of select="./following-sibling::word[1]/rel-pos-sWord-0"/></bigram-rel-pos-sWordLevel-0>
                                         <bigram-rel-pos-sWordLevel-1><xsl:value-of select="./rel-pos-sWord-1"/>=start</bigram-rel-pos-sWordLevel-1>
                                         <bigram-rel-pos-sWordLevel-1><xsl:value-of select="./rel-pos-sWord-1"/>=<xsl:value-of select="./following-sibling::word[1]/rel-pos-sWord-1"/></bigram-rel-pos-sWordLevel-1>
                                         <bigram-rel-pos-sWordLevel-2><xsl:value-of select="./rel-pos-sWord-2"/>=start</bigram-rel-pos-sWordLevel-2>
                                         <bigram-rel-pos-sWordLevel-2><xsl:value-of select="./rel-pos-sWord-2"/>=<xsl:value-of select="./following-sibling::word[1]/rel-pos-sWord-2"/></bigram-rel-pos-sWordLevel-2>
                                         
                                         <bigram-rel-sWordLevel-0>start=<xsl:value-of select="./rel-sWord-0"/></bigram-rel-sWordLevel-0>
                                         <bigram-rel-sWordLevel-0><xsl:value-of select="./rel-sWord-0"/>=<xsl:value-of select="./following-sibling::word[1]/rel-sWord-0"/></bigram-rel-sWordLevel-0>
                                         <bigram-rel-sWordLevel-1>start=<xsl:value-of select="./rel-sWord-1"/></bigram-rel-sWordLevel-1>
                                         <bigram-rel-sWordLevel-1><xsl:value-of select="./rel-sWord-1"/>=<xsl:value-of select="./following-sibling::word[1]/rel-sWord-1"/></bigram-rel-sWordLevel-1>
                                         <bigram-rel-sWordLevel-2>start=<xsl:value-of select="./rel-sWord-2"/></bigram-rel-sWordLevel-2>
                                         <bigram-rel-sWordLevel-2><xsl:value-of select="./rel-sWord-2"/>=<xsl:value-of select="./following-sibling::word[1]/rel-sWord-2"/></bigram-rel-sWordLevel-2>
                                         
                                         <bigram-pos-sWordLevel-0>start=<xsl:value-of select="./pos-sWord-0"/></bigram-pos-sWordLevel-0>
                                         <bigram-pos-sWordLevel-0><xsl:value-of select="./pos-sWord-0"/>=<xsl:value-of select="./following-sibling::word[1]/pos-sWord-0"/></bigram-pos-sWordLevel-0>
                                         <bigram-pos-sWordLevel-1>start=<xsl:value-of select="./pos-sWord-1"/></bigram-pos-sWordLevel-1>
                                         <bigram-pos-sWordLevel-1><xsl:value-of select="./pos-sWord-1"/>=<xsl:value-of select="./following-sibling::word[1]/pos-sWord-1"/></bigram-pos-sWordLevel-1>
                                         <bigram-pos-sWordLevel-2>start=<xsl:value-of select="./pos-sWord-2"/></bigram-pos-sWordLevel-2>
                                         <bigram-pos-sWordLevel-2><xsl:value-of select="./pos-sWord-2"/>=<xsl:value-of select="./following-sibling::word[1]/pos-sWord-2"/></bigram-pos-sWordLevel-2>
                                         
                                         <trigram-rel-pos-sWordLevel-0>start=<xsl:value-of select="./rel-pos-sWord-0"/>=<xsl:value-of select="./following-sibling::word[1]/rel-pos-sWord-0"/></trigram-rel-pos-sWordLevel-0>
                                         <trigram-rel-pos-sWordLevel-0><xsl:value-of select="./rel-pos-sWord-0"/>=<xsl:value-of select="./following-sibling::word[1]/rel-pos-sWord-0"/>=<xsl:value-of select="./following-sibling::word[2]/rel-pos-sWord-0"/></trigram-rel-pos-sWordLevel-0>
                                         <trigram-rel-pos-sWordLevel-1>start=<xsl:value-of select="./rel-pos-sWord-1"/>=<xsl:value-of select="./following-sibling::word[1]/rel-pos-sWord-1"/></trigram-rel-pos-sWordLevel-1>
                                         <trigram-rel-pos-sWordLevel-1><xsl:value-of select="./rel-pos-sWord-1"/>=<xsl:value-of select="./following-sibling::word[1]/rel-pos-sWord-1"/>=<xsl:value-of select="./following-sibling::word[2]/rel-pos-sWord-1"/></trigram-rel-pos-sWordLevel-1>
                                         <trigram-rel-pos-sWordLevel-2>start=<xsl:value-of select="./rel-pos-sWord-2"/>=<xsl:value-of select="./following-sibling::word[1]/rel-pos-sWord-2"/></trigram-rel-pos-sWordLevel-2>
                                         <trigram-rel-pos-sWordLevel-2><xsl:value-of select="./rel-pos-sWord-2"/>=<xsl:value-of select="./following-sibling::word[1]/rel-pos-sWord-2"/>=<xsl:value-of select="./following-sibling::word[2]/rel-pos-sWord-2"/></trigram-rel-pos-sWordLevel-2>
                                         
                                         <trigram-rel-sWordLevel-0>start=<xsl:value-of select="./rel-sWord-0"/>=<xsl:value-of select="./following-sibling::word[1]/rel-sWord-0"/></trigram-rel-sWordLevel-0>
                                         <trigram-rel-sWordLevel-0><xsl:value-of select="./rel-sWord-0"/>=<xsl:value-of select="./following-sibling::word[1]/rel-sWord-0"/>=<xsl:value-of select="./following-sibling::word[2]/rel-sWord-0"/></trigram-rel-sWordLevel-0>
                                         <trigram-rel-sWordLevel-1>start=<xsl:value-of select="./rel-sWord-1"/>=<xsl:value-of select="./following-sibling::word[1]/rel-sWord-1"/></trigram-rel-sWordLevel-1>
                                         <trigram-rel-sWordLevel-1><xsl:value-of select="./rel-sWord-1"/>=<xsl:value-of select="./following-sibling::word[1]/rel-sWord-1"/>=<xsl:value-of select="./following-sibling::word[2]/rel-sWord-1"/></trigram-rel-sWordLevel-1>
                                         <trigram-rel-sWordLevel-2>start=<xsl:value-of select="./rel-sWord-2"/>=<xsl:value-of select="./following-sibling::word[1]/rel-sWord-2"/></trigram-rel-sWordLevel-2>
                                         <trigram-rel-sWordLevel-2><xsl:value-of select="./rel-sWord-2"/>=<xsl:value-of select="./following-sibling::word[1]/rel-sWord-2"/>=<xsl:value-of select="./following-sibling::word[2]/rel-sWord-2"/></trigram-rel-sWordLevel-2>
                                         
                                         <trigram-pos-sWordLevel-0>start=<xsl:value-of select="./pos-sWord-0"/>=<xsl:value-of select="./following-sibling::word[1]/pos-sWord-0"/></trigram-pos-sWordLevel-0>
                                         <trigram-pos-sWordLevel-0><xsl:value-of select="./pos-sWord-0"/>=<xsl:value-of select="./following-sibling::word[1]/pos-sWord-0"/>=<xsl:value-of select="./following-sibling::word[2]/pos-sWord-0"/></trigram-pos-sWordLevel-0>
                                         <trigram-pos-sWordLevel-1>start=<xsl:value-of select="./pos-sWord-1"/>=<xsl:value-of select="./following-sibling::word[1]/pos-sWord-1"/></trigram-pos-sWordLevel-1>
                                         <trigram-pos-sWordLevel-1><xsl:value-of select="./pos-sWord-1"/>=<xsl:value-of select="./following-sibling::word[1]/pos-sWord-1"/>=<xsl:value-of select="./following-sibling::word[2]/pos-sWord-1"/></trigram-pos-sWordLevel-1>
                                         <trigram-pos-sWordLevel-2>start=<xsl:value-of select="./pos-sWord-2"/>=<xsl:value-of select="./following-sibling::word[1]/pos-sWord-2"/></trigram-pos-sWordLevel-2>
                                         <trigram-pos-sWordLevel-2><xsl:value-of select="./pos-sWord-2"/>=<xsl:value-of select="./following-sibling::word[1]/pos-sWord-2"/>=<xsl:value-of select="./following-sibling::word[2]/pos-sWord-2"/></trigram-pos-sWordLevel-2>
                                         
                                         
                                     </xsl:when>
                                     <xsl:otherwise>
                                        
                                        <bigram-rel-pos-sWordLevel-0><xsl:value-of select="./rel-pos-sWord-0"/>=<xsl:value-of select="./following-sibling::word[1]/rel-pos-sWord-0"/></bigram-rel-pos-sWordLevel-0>
                                        <bigram-rel-pos-sWordLevel-1><xsl:value-of select="./rel-pos-sWord-1"/>=<xsl:value-of select="./following-sibling::word[1]/rel-pos-sWord-1"/></bigram-rel-pos-sWordLevel-1>
                                        <bigram-rel-pos-sWordLevel-2><xsl:value-of select="./rel-pos-sWord-2"/>=<xsl:value-of select="./following-sibling::word[1]/rel-pos-sWord-2"/></bigram-rel-pos-sWordLevel-2>
                                         
                                         <bigram-rel-sWordLevel-0><xsl:value-of select="./rel-sWord-0"/>=<xsl:value-of select="./following-sibling::word[1]/rel-sWord-0"/></bigram-rel-sWordLevel-0>
                                         <bigram-rel-sWordLevel-1><xsl:value-of select="./rel-sWord-1"/>=<xsl:value-of select="./following-sibling::word[1]/rel-sWord-1"/></bigram-rel-sWordLevel-1>
                                         <bigram-rel-sWordLevel-2><xsl:value-of select="./rel-sWord-2"/>=<xsl:value-of select="./following-sibling::word[1]/rel-sWord-2"/></bigram-rel-sWordLevel-2>
                                         
                                         <bigram-pos-sWordLevel-0><xsl:value-of select="./pos-sWord-0"/>=<xsl:value-of select="./following-sibling::word[1]/pos-sWord-0"/></bigram-pos-sWordLevel-0>
                                         <bigram-pos-sWordLevel-1><xsl:value-of select="./pos-sWord-1"/>=<xsl:value-of select="./following-sibling::word[1]/pos-sWord-1"/></bigram-pos-sWordLevel-1>
                                         <bigram-pos-sWordLevel-2><xsl:value-of select="./pos-sWord-2"/>=<xsl:value-of select="./following-sibling::word[1]/pos-sWord-2"/></bigram-pos-sWordLevel-2>
                                        
                                         <trigram-rel-pos-sWordLevel-0><xsl:value-of select="./rel-pos-sWord-0"/>=<xsl:value-of select="./following-sibling::word[1]/rel-pos-sWord-0"/>=<xsl:value-of select="./following-sibling::word[2]/rel-pos-sWord-0"/></trigram-rel-pos-sWordLevel-0>
                                         <trigram-rel-pos-sWordLevel-1><xsl:value-of select="./rel-pos-sWord-1"/>=<xsl:value-of select="./following-sibling::word[1]/rel-pos-sWord-1"/>=<xsl:value-of select="./following-sibling::word[2]/rel-pos-sWord-1"/></trigram-rel-pos-sWordLevel-1>
                                         <trigram-rel-pos-sWordLevel-2><xsl:value-of select="./rel-pos-sWord-2"/>=<xsl:value-of select="./following-sibling::word[1]/rel-pos-sWord-2"/>=<xsl:value-of select="./following-sibling::word[2]/rel-pos-sWord-2"/></trigram-rel-pos-sWordLevel-2>
                                         
                                         <trigram-rel-sWordLevel-0><xsl:value-of select="./rel-sWord-0"/>=<xsl:value-of select="./following-sibling::word[1]/rel-sWord-0"/>=<xsl:value-of select="./following-sibling::word[2]/rel-sWord-0"/></trigram-rel-sWordLevel-0>
                                         <trigram-rel-sWordLevel-1><xsl:value-of select="./rel-sWord-1"/>=<xsl:value-of select="./following-sibling::word[1]/rel-sWord-1"/>=<xsl:value-of select="./following-sibling::word[2]/rel-sWord-1"/></trigram-rel-sWordLevel-1>
                                         <trigram-rel-sWordLevel-2><xsl:value-of select="./rel-sWord-2"/>=<xsl:value-of select="./following-sibling::word[1]/rel-sWord-2"/>=<xsl:value-of select="./following-sibling::word[2]/rel-sWord-2"/></trigram-rel-sWordLevel-2>
                                         
                                         <trigram-pos-sWordLevel-0><xsl:value-of select="./pos-sWord-0"/>=<xsl:value-of select="./following-sibling::word[1]/pos-sWord-0"/>=<xsl:value-of select="./following-sibling::word[2]/pos-sWord-0"/></trigram-pos-sWordLevel-0>
                                         <trigram-pos-sWordLevel-1><xsl:value-of select="./pos-sWord-1"/>=<xsl:value-of select="./following-sibling::word[1]/pos-sWord-1"/>=<xsl:value-of select="./following-sibling::word[2]/pos-sWord-1"/></trigram-pos-sWordLevel-1>
                                         <trigram-pos-sWordLevel-2><xsl:value-of select="./pos-sWord-2"/>=<xsl:value-of select="./following-sibling::word[1]/pos-sWord-2"/>=<xsl:value-of select="./following-sibling::word[2]/pos-sWord-2"/></trigram-pos-sWordLevel-2>
                                         
                                     </xsl:otherwise>
                                 </xsl:choose>
                                 
                                 
                                 
                                                                    
                                 
                             </xsl:otherwise>
                             
                         </xsl:choose>
                         
                     </word>
                      
                      
                  </xsl:for-each>
                  
              </sentence>
          </xsl:for-each>
            
        </sWord_document>
        
        
        
    </xsl:template>
    
    
</xsl:stylesheet>