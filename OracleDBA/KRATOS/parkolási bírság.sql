--TAB=ROGIZTES-UGYIRAT
select r.rendszam, g.megnevezes, r.potdij_helyszin, r.potdij1_osszeg, r.*, u.*
from PARK.ROGZITESEK r
left outer join PARK.UGYIRATOK u on u.rogzitesek_id = r.rogzitesek_id
left outer join PARK.UGYIRAT_JARMUVEK j on u.ugyiratok_id = j.ugyiratok_id
left outer join KERET.GYARTMANYOK g on j.gyartmanyok_id = g.gyartmanyok_id and g.aktiv_jel = 1
where 1=1
and r.rogzites_ido >= timestamp'2018-11-10 08:00:00' and r.rogzites_ido < timestamp'2018-11-11 00:00:00'
and r.potdij_helyszin like '%KAPÁS%'
order by 1 desc;

--TAB=ELOIRAS
select eb.eloiras_befizetes_id, e.*, eb.*
from PENZ.ELOIRAS e
left outer join PENZ.ELOIRAS_BEFIZETES eb on e.eloiras_id = eb.eloiras_id and eb.aktiv_jel = 1
where e.aktiv_jel = 1
--and e.eloiras_id = 1152986
and e.rendszam like '%PSS%'
and e.eloiras_dat >= timestamp'2018-11-10 08:00:00' and e.eloiras_dat < timestamp'2018-11-11 00:00:00'
order by 1 desc;

--TAB=BEFIZETES_TETEL
select ebt.* from PENZ.ELOIRAS_BEFIZETES_TETEL ebt where ebt.aktiv_jel = 1
--and ebt.eloiras_befizetes_id = 
order by 1 desc;

--TAB=POSTA_TETEL
select pt.* from PENZ.POSTA_TETEL pt where 1=1
and pt.befizetes_datum >= date'2018-11-07'
--and pt.befizeto_azon = 
and pt.osszeg = 5500
order by 1 desc;
