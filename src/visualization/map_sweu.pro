;
; Copyright 2013 Netherlands eScience Center
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
; http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.
;

;PLOT multiple radars' ppi's

;SET the radar ids of the radars to be processed
radar_ids_sweu = ['NL','PL','SK','FR']
radar_ids = radar_names(radar_ids_sweu)

subdir = '0'
directory = GETENV('IDL_ENRAM_CLUTTER_SENSITIVITY')+subdir

; SPECIFY the time interval to process.
date='20110901'
time='1730'

find_files,files,date,time,radar_ids,directory=directory

IF KEYWORD_SET(definitions) THEN dummy=TEMPORARY(definitions)
FOR id=0,N_ELEMENTS(radar_ids)-1 DO BEGIN
  radar_definitions,radar_ids[id],radar_definition
  definitions= KEYWORD_SET(definitions) ? [definitions,radar_definition] : radar_definition
ENDFOR

psfile=GETENV('IDL_ENRAM_VISUALIZATION_OUTPUT')+'map_sweu_'+date+time+'.ps' ; FIXME

scan=1
grid=1

plot_lon=0
plot_lat=45
limit=[42,-4,54,15]

map_prof,files,limit,$
date=date,time=time,$
definitions=definitions,$
coast=0,$
bg=1,$
plot_lon=plot_lon,$
plot_lat=plot_lat,$
grid=grid,$
psfile=psfile,$
radar_cross=0,$
radar_title=2

END
