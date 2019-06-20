out_ps=midterm.ps  
gmt set PS_MEDIA A4 

input_list=POPULATION.csv
# start gmt session
gmt psxy -R0/1/0/1 -JX1c -T -K > $out_ps 
  
gmt psbasemap -R-160/-65/20/65 -Jm0.25 -B5 -B+tPOPULATION -G67/169/190 -Xc -Yc -O -K >> $out_ps
gmt pscoast -R -J -B -W0.1 -G106/205/117 -Di -N1 -O -K >> $out_ps
awk '{print $1, $2, log($3)/10}' $input_list | gmt psxy -R -J -Sc -W0.1 -G242/171/52 -O -K >> $out_ps
awk '{print $1, $2, $4 " " $3*10 " K"}' $input_list | gmt pstext -R -J -N -F+f5,Helvetica,black -O -K >> $out_ps

gmt pslegend -R -J -Gwhite -D-155/25+w3/3+jBL+l2  -O -K << EOF >> $out_ps
S 0.1 c 0.230259 242/171/52 0.25p 0.5 100K
S 0.1 c 0.460517 242/171/52 0.25p 0.5 1,000K
S 0.1 c 0.690776 242/171/52 0.25p 0.5 10,000K
EOF



# end gmt session
gmt psxy -R -J -O -T >> $out_ps 
  
# convert to pdf
gmt psconvert $out_ps -P -Tf
# convert to png
gmt psconvert $out_ps -P -Tg