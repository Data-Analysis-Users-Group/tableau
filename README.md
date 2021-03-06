---
title: "Tableau - Icons and Colors"
date: "January 6, 2016"
output: 
  html_document: 
    toc: yes
    fontsize: 14pt
---

<style type="text/css">
body{
  font-size: 16pt;
}
</style>

<hr>
<br>

![Star Wars spacecraft](http://icons.iconarchive.com/icons/jonathan-rey/star-wars-vehicles/icons-390.jpg)

# Icons

Detailed instructions for adding custom icons and images to your charts or dashboards is online at [http://www.evolytics.com/blog/tableau-201-how-to-add-instructions-using-custom-shape-palettes/](http://www.evolytics.com/blog/tableau-201-how-to-add-instructions-using-custom-shape-palettes/).  


Your Tableau icon folder can be found by searching for `"Preferences.tps"` in your windows search bar, or by navigating to `C:\Users\[enter your user name]\Documents\My Tableau Repository`.  

Once there open the __`"Shapes"`__ folder and add your folder of custom icons.  

__*NOTE If Tableau is already open, you will need to restart Tableau before being able to see the newly added shapes.*__
 
<hr>

# Colors

![Star Wars Palettes](http://www.fubiz.net/wp-content/uploads/2015/04/The-Colors-of-Star-Wars-Palettes-10.png)

Detailed instructions for adding custom color palettes to Tableau is online at [http://kb.tableau.com/articles/knowledgebase/creating-custom-color-palettes](http://kb.tableau.com/articles/knowledgebase/creating-custom-color-palettes)

![Preferences.tps](http://kbcdn.tableausoftware.com/images/custom_color5.png)

<br>

Instructions on how to quickly create new color palettes in R are below. Other helpful online resources include: [http://colorbrewer2.org/](http://colorbrewer2.org/), [https://coolors.co/app](https://coolors.co/app), and [Image Color Getter](http://html-color-codes.info/colors-from-image/)


```{r, echo=F}
options(warn = -1)
par(mar=c(0,1,1,0))
```
### Required packages
```{r, message=F}
#-- Load required packages
require(devtools)

#-- For image processing
#source("https://bioconductor.org/biocLite.R")
#biocLite("EBImage")
library(EBImage)

#-- For color analysis
#install_github("ramnathv/rblocks")
#install_github("woobe/rPlotter")
library(rPlotter)

#-- Wes Anderson film colors package
#install_github("karthik/wesanderson")
library(wesanderson)
library(ggplot2)
```


### Wes Anderson Movies
```{r}
wes_palette("Moonrise2")
wes_palette("GrandBudapest2")
wes_palette("Darjeeling")
wes_palette("FantasticFox")

#-- Print color hex codes
wes_palettes[["FantasticFox"]]

```

### Star Wars colors
```{r, tidy=T}
##-- Reference: 
# http://www.mepheoscience.com/colourful-ecology-part-1-extracting-colours-from-an-image-and-selecting-them-using-community-phylogenetics-theory/
# http://www.fubiz.net/2015/04/20/the-colors-of-star-wars-palettes/the-colors-of-star-wars-palettes-10/
# Simpsons - http://blenditbayes.blogspot.co.uk/2014/05/towards-yet-another-r-colour-palette

#-- Force awakens
force_awakens <- extract_colours("http://www.fubiz.net/wp-content/uploads/2015/04/The-Colors-of-Star-Wars-Palettes-8.jpg", num_col = 22)

#-- plot extracted palette
#grid <- block_grid(22, type = "vector").html
# Simpsons - http://i.imgur.com/0gXvpYJ.png

#grid[1:22] <- force_awakens
#grid

pie(rep(1, 25), col = force_awakens, main = "Palette based on Force awakens")

structure(force_awakens, class = "palette", name = "force_awakens")


#-- Clones
attack_clones <- extract_colours("http://www.fubiz.net/wp-content/uploads/2015/04/The-Colors-of-Star-Wars-Palettes-6.jpg", num_col = 22)
#-- plot extracted palette
structure(attack_clones, class = "palette", name = "attack_clones")


#-- A New Hope
new_hope <- extract_colours("http://www.fubiz.net/wp-content/uploads/2015/04/The-Colors-of-Star-Wars-Palettes-2.jpg", num_col = 22)

#-- plot extracted palette
structure(new_hope, class = "palette", name = "new_hope")


#-- MPCA Logo
mpca <- extract_colours("http://wac.450f.edgecastcdn.net/80450F/wjon.com/files/2010/12/mpca.jpg", num_col = 6)

#-- plot extracted palette
pie(rep(1, 6), col = mpca, main = "Palette based on MPCA logo", cex.main=0.8)

structure(mpca, class = "palette", name = "mpca")
```


### Create a new tableau palette 
#### _for pasting into your `Preferences.tps` file_
```{r}
##-- Create a Tableau palette function
##-- Reference: http://kb.tableau.com/articles/knowledgebase/creating-custom-color-palettes

tableau_palette <- function(color_list = c("#FBFBFB", "#DFDFDF"), 
                            name = "New Palette") {
  
out <- paste0(c("<workbook> \n\t <preferences>
                <color-palette name=\"", name, "\" type=\"regular\"> \n",
                paste("\t\t\t <color>", color_list, "</color> \n"),
                "\t\t </color-palette> \n\t </preferences> \n </workbook>"), 
              collapse="")

cat(out)
}

tableau_palette(mpca, "MPCA Logo")

tableau_palette(force_awakens, "Force Awakens")

tableau_palette(wes_palettes[["FantasticFox"]], "Fox")

```
