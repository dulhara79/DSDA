CREATE TABLE Planes (
xDoc Xml not null
)

INSERT INTO Planes VALUES (
'<?xml version="1.0" encoding="UTF-8"?>
<planes>
 <plane>
 <year> 1977 </year>
 <make> Cessna </make>
 <model> Skyhawk </model>
 <color> Light blue and white </color>
 </plane>
 <plane>
 <year> 1975 </year>
 <make> Piper </make>
 <model> Apache </model>
 <color> White </color>
 </plane>
 <plane>
 <year> 1960 </year>
 <make> Cessna </make>
 <model> Centurian </model>
 <color> Yellow and white </color>
 </plane>
 <plane>
 <year> 1956 </year>
 <make> Piper </make>
 <model> Tripacer </model>
 <color> Blue </color>
 </plane>
</planes>'
)

select xDoc.query('<oldPlanes>
{
  for $plane in //plane
  where $plane/year < 1970
  return ($plane/make, $plane/model)
}
</oldPlanes>')
from Planes

SELECT xDoc.query (' let $planes := /planes/plane
return <results>
{
 for $x in $planes
 where $x/year >= 1970
 order by ($x/year)[1]
 return ($x/make, $x/model,$x/year )
}
</results>
')
FROM planesselect xDoc.query('<table><tr><th>Model</th><th>Color</th></tr>{for $planes in //planereturn (<tr><td>{data($planes/model)}</td>,<td>{data($planes/color)}</td></tr>)}</table>')from Planesdrop table Planes