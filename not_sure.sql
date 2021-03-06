select 

max( concat(ITEMVIEW.record_type_code, ITEMVIEW.record_num, 'a')) as "irecnum",
max( concat(BIBVIEW.record_type_code, BIBVIEW.record_num, 'a')) as "brecnum",
max( ITEMVIEW.item_status_code) as "istatuscode",
MAX (ITEMVIEW.itype_code_num) AS "itypecode",
MAX (cast (BIBVIEW.is_available_at_library as varchar)) as "bisavail"

-- Can leave this out, as I filter against it.
-- MAX (BIBVIEW.bcode3) as "bcode3"

-- I'm also not pulling STATUS : DUE date, because then I have 
-- to join the circ data table, and I don't want to, and I 
-- don't think It's necessary.

from sierra_view.bib_record_item_record_link BIBITEMLINK

left join sierra_view.item_view ITEMVIEW
on BIBITEMLINK.item_record_id = ITEMVIEW.id

LEFT JOIN sierra_view.bib_view BIBVIEW
on BIBITEMLINK.bib_record_id = BIBVIEW.id

where
ITEMVIEW.item_status_code IN ('-', '!', 't')
AND ITEMVIEW.itype_code_num NOT IN (60, 50, 62, 54, 53, 1, 0, 25, 26, 27, 0, 70, 72, 100, 77, 99)
AND ITEMVIEW.location_code NOT IN ('apc', 'cpc', 'gpc', 'lpc', 'mjpc', 'mpc', 'npc', 'rpc', 'spc')
AND "bcode3" = 'n'

GROUP BY
BIBITEMLINK.bib_record_id

order by 4
;