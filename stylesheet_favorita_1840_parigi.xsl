<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:tei="http://www.tei-c.org/ns/1.0">

  <!-- Identity template: copia tutti gli elementi e attributi così come sono -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Template per l'elemento radice dell'HTML -->
  <xsl:template match="tei:TEI">
    <html>
      <style>
        .titoletto {
          font-weight:bold;
        }
        .line-break span {
          display: block;
        }
        .corsivo {
          font-style:italic;
        }
        .centrale {
          text-align:center;
        }
        .spostato {
          margin-left:4vw;
        }
      </style>
      <body>
        <div class="centrale">
          <p class="titoletto">
            <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
          </p>
          <p class="titoletto">
            <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:publisher"/>, 
            <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:date"/> - by 
            <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt[1]/tei:name"/>
          </p>
        </div>
        <div class="spostato">
          <p class="titoletto">
            <xsl:value-of select="tei:text/tei:body/tei:div/tei:head"/>
          </p>
          <p class="corsivo">
            <xsl:value-of select="tei:text/tei:body/tei:div/tei:stage"/>
          </p>
        </div>
        <xsl:apply-templates select="tei:text/tei:body/tei:div/tei:sp"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="tei:sp">
    <p class="line-break">
      <xsl:apply-templates select="node()"/>
    </p>
  </xsl:template>

  <xsl:template match="tei:sp/tei:speaker">
    <span class="titoletto">
      <xsl:value-of select="text()"/>
    </span>
  </xsl:template>

  <xsl:template match="tei:sp/tei:stage">
    <span class="corsivo">
      <xsl:value-of select="text()"/>
    </span>
  </xsl:template>

<xsl:template match="tei:caesura">
  <xsl:element name="br"/>
  <p style="color:red;">Caesura Template Matched!</p>
</xsl:template>
  
  <!-- Template for caesura -->
	<!--<xsl:template match="tei:caesura">
	  <span class="line-break">
		<xsl:element name="br" />
	  </span>
	</xsl:template>-->

  <xsl:template match="tei:l">
    <span>
      <xsl:call-template name="replace-string">
        <xsl:with-param name="text" select="."/>
      </xsl:call-template>
    </span>
  </xsl:template>

  <!-- Template per la sostituzione della sottostringa -->
  <xsl:template name="replace-string">
    <xsl:param name="text"/>
    <xsl:choose>
      <!-- Se il testo contiene la sottostringa, sostituiscila con "br" -->
      <xsl:when test="contains($text, 'stringa_da_sostituire')">
        <xsl:value-of select="substring-before($text, 'stringa_da_sostituire')"/>
        <xsl:text>stringa_sostituente</xsl:text>
        <xsl:call-template name="replace-string">
          <xsl:with-param name="text" select="substring-after($text, 'stringa_da_sostituire')"/>
        </xsl:call-template>
      </xsl:when>
      <!-- Se il testo non contiene la sottostringa, mantieni il testo invariato -->
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
