<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Travail à faire : Compléter les parties <a compléter> de 1 à 10 afin d'obtenir le résultat expliqué dans la vidéo du laboratoire -->
	<!-- !!!!! Nous vous rendons attentif que vous n'avez PAS LE DROIT de modifier le reste du document, mais uniquement ces parties -->

	<xsl:output
			method 			= "html"
			encoding 		= "UTF-8"
			doctype-public 	= "-//W3C//DTD HTML 4.01//EN"
			doctype-system 	= "http://www.w3.org/TR/html4/strict.dtd"
			indent 			= "yes"
	/>

	<xsl:key name="pokemonTypes" match="/pokedex/pokemon/type" use="text()"></xsl:key>

	<xsl:template match="/">

		<html>

			<style>

				button[aria-expanded="true"] {
				  border: 3px solid;
				}

			</style>

			<head>
				<title>Attrapez les tous...</title>

		        <script type="text/javascript" src="js/jquery-3.4.1.min.js" />
		        <script type="text/javascript" src="js/bootstrap.min.js" />
		        <link rel="stylesheet" href="css/bootstrap.min.css" />

			</head>

			<body>

				<div class="container-fluid">

					  <form>
					     <select name="choix_generation" id="choix_generation" class="form-control">
					     	<option value="1">Génération 1</option>
					     	<option value="2">Génération 2</option>
					     	<option value="3">Génération 3</option>
					     	<option value="4">Génération 4</option>
					     	<option value="5">Génération 5</option>
					     	<option value="6">Génération 6</option>
					     	<option value="7">Génération 7</option>
					     </select>
					 </form>

					<div id="accordion">

						<xsl:variable name="types" select="/pokedex/pokemon/type/text()[generate-id(..) = generate-id(key('pokemonTypes', .))]" />

						<xsl:for-each select="$types">

							&#160;<button data-toggle="collapse" role="button" class="btn btn-outline-primary">

								<xsl:attribute name="data-target">
									<xsl:value-of select="concat('#', .)" />
								</xsl:attribute>
								
								<xsl:value-of select="." />
						    
						    </button>

						</xsl:for-each>

						<xsl:for-each select="$types">

							<xsl:variable name="type" select="." />

							<div data-parent="#accordion" class="collapse">

								<xsl:attribute name="id">
									<xsl:value-of select="." />
								</xsl:attribute>

								<xsl:call-template name="lister_pokemon">
									<xsl:with-param name="filtre" select="/pokedex/pokemon/type[text()=$type]/parent::pokemon" />
								</xsl:call-template>

							</div>

						</xsl:for-each>

					</div>

				</div>

			</body>

			<!-- Javascript pour le choix de la génération, à ne pas modifier --> 
			<script type="text/javascript">

				generation = $("#choix_generation").val();

				$("[role=pokemon]").hide(1000);
				$("[role=pokemon][generation=" + generation + "]").show(1000);

				$("#choix_generation").change(function() {

					generation = $(this).val();

					$("[role=pokemon]").hide(1000);
					$("[role=pokemon][generation=" + generation + "]").show(1000);



				});
			</script>

		</html>

	</xsl:template>

	<xsl:template name="lister_pokemon">

		<xsl:param name="filtre"/>

		<div class="row">

			<xsl:for-each select="$filtre">

				<xsl:sort order="ascending" select="id" data-type="number"/>
				<xsl:apply-templates select="." />

			</xsl:for-each>

		</div>

	</xsl:template>

	<xsl:template match="pokemon">

		<div class="col-2 mb-2" role="pokemon">

			<xsl:attribute name="generation">
				<xsl:choose>
					<xsl:when test="./id &lt;= 151">1</xsl:when>
					<xsl:when test="./id &lt;= 251">2</xsl:when>
					<xsl:when test="./id &lt;= 386">3</xsl:when>
					<xsl:when test="./id &lt;= 493">4</xsl:when>
					<xsl:when test="./id &lt;= 649">5</xsl:when>
					<xsl:when test="./id &lt;= 721">6</xsl:when>
					<xsl:when test="./id &lt;= 809">7</xsl:when>
					<xsl:otherwise>unknown</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

			<div class="card">

				<div class="card-header">

					<h5><xsl:value-of select="concat(id, ' - ', name/french)" /></h5>

				</div>

				<div class="card-body">

					<div class="row">

						<div class="col-12">
							<xsl:apply-templates select="id" />
						</div>

						<div class="col-12">
							<xsl:apply-templates select="base" />
						</div>

					</div>

				</div>

			</div>

		</div>

	</xsl:template>

	<xsl:template match="id">

		<img width="100%">
				<xsl:attribute name="src">
					<xsl:value-of select="concat('images/',format-number(.,'000'),'.png')" />
				</xsl:attribute>
		</img>

	</xsl:template>

	<xsl:template match="base">

		<table class="table table-stripped">
			
			<tr>
				<td>Points de vie (HP)</td>
				<td><xsl:value-of select="HP" /></td>
			</tr>

			<tr>
				<td>Attaque</td>
				<td><xsl:value-of select="Attack" /></td>
			</tr>

			<tr>
				<td>Defense</td>
				<td><xsl:value-of select="Defense" /></td>
			</tr>

			<tr>
				<td>Vitesse</td>
				<td><xsl:value-of select="Speed" /></td>
			</tr>


		</table>

	</xsl:template>

</xsl:stylesheet>
