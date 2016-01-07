
### Create a new tableau palette for pasting into your `Preferences.tps` file
##-- Reference: http://kb.tableau.com/articles/knowledgebase/creating-custom-color-palettes

##-- Create a Tableau palette function

tableau_palette <- function(color_list = c("#FBFBFB", "#DFDFDF"), 
                            name = "New Palette") {
  
out <- paste0(c("<workbook> \n\t <preferences>
                <color-palette name=\"", name, "\" type=\"regular\"> \n",
                paste("\t\t\t <color>", color_list, "</color> \n"),
                "\t\t </color-palette> \n\t </preferences> \n </workbook>"), 
              collapse="")

cat(out)
}
