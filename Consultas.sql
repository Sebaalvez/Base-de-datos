
GO
Use ObligatorioAgosto2018

--Consulta de los usuarios con la mayor cantidad de pasajes comprados a su nombre.
SELECT  P.nombre , COUNT(PA.idPasaje) [Cantidad de Pasajes]
FROM  [dbo].[PASAJERO] P
JOIN  [dbo].[usuario] U   ON P.idpasajero = U.IdPasajero
JOIN  [dbo].[Pasaje]  PA  ON PA.idpasajero = P.idpasajero
GROUP BY P.nombre
HAVING COUNT(PA.idPasaje) >= (SELECT top 1 COUNT(PA.idPasaje) [Cantidad de Pasajes]
							  FROM  [dbo].[PASAJERO] P
							  JOIN  [dbo].[usuario] U   ON P.idpasajero = U.IdPasajero
							  JOIN  [dbo].[Pasaje]  PA  ON PA.idpasajero = P.idpasajero
							 GROUP BY P.nombre
							 ORDER BY COUNT(PA.idPasaje) DESC)





-- Consulta de los aviones con más de 20 asientos en clase “A” que no tengan asignado ningún destino que parta el día de mañana.

SELECT * FROM Avion A
WHERE A.idavion IN (SELECT ASI.idavion
						FROM [dbo].[ASIENTO] ASI
						WHERE ASI.clase = 'A'
						GROUP BY ASI.idavion,ASI.clase
						HAVING COUNT(ASI.idasiento)>20)
AND  A.idavion IN (SELECT V.idavion
						FROM [dbo].[Vuelo] V
						WHERE  CONVERT(char(10),v.FechaHoraSalida,103) <>  CONVERT (char(10), getdate() + 1, 103))






						



-- Consulta  de los pasajeros para los cuales haya registrados en el sistema más de 5 pasajes pagos.


SELECT P.idpasajero,P.nombre,P.apaterno,P.amaterno,P.tipo_documento,P.num_documento,P.fecha_nacimiento,P.idpais,P.telefono,P.email , COUNT(PAGO.idpago)[Pasajes pagos]
FROM [dbo].[PASAJERO] P
JOIN [dbo].[PAGO] ON P.idpasajero = PAGO.idpasajero
JOIN [dbo].[Pasaje] ON PAGO.idreserva = Pasaje.idreserva
                    AND P.idpasajero = PASAJE.idpasajero
GROUP BY P.idpasajero,P.nombre,P.apaterno,P.amaterno,P.tipo_documento,P.num_documento,P.fecha_nacimiento,P.idpais,P.telefono,P.email
HAVING COUNT(PAGO.idpago)>5











-- Consulta que corresponde a pasajes comprados para el destino cuyo IdVuelo es 255.
SELECT distinct  P.idpasajero,P.nombre,P.apaterno,P.amaterno, A.idasiento,A.fila,v.idVuelo
FROM [dbo].[PASAJERO] P
JOIN [dbo].Pasaje PA   ON P.idpasajero = PA.idpasajero 
JOIN [dbo].[ASIENTO] A ON PA.idasiento = A.idasiento
JOIN [dbo].[Avion] AV  ON AV.idavion = A.idavion
JOIN [dbo].[Vuelo] V   ON V.idavion = AV.idavion
WHERE V.idVuelo = '255' order by p.idpasajero













SELECT v.idAeropuertoDestino,p.idpasajero,COUNT(PAS.idPasaje)[Cantidad de pasajes]
FROM [dbo].[Vuelo] v
JOIN [dbo].[Pasaje] PAS ON v.idavion = PAS.idavion
JOIN [dbo].[PAGO] PAG ON PAS.idreserva = PAG.idreserva
JOIN [dbo].[RESERVA] R    ON R.idreserva = PAG.idreserva
JOIN [dbo].[PASAJERO] P ON PAG.idpasajero= P.idpasajero
WHERE YEAR(PAG.fecha)='2018' AND MONTH(PAG.fecha) = '9' and p.email='soyuruguayo@gmail.com'
GROUP BY v.idAeropuertoDestino,p.idpasajero
order by v.idAeropuertoDestino







select  * 
from pago P
JOIN pasajero PASA        ON p.idpasajero = pasa.idpasajero
JOIN [dbo].[RESERVA] R    ON R.idreserva = P.idreserva
JOIN [dbo].[Pasaje]  PAS  ON PAS.idpasajero = P.idpasajero
                          AND PAS.idreserva = R.idreserva
JOIN [dbo].[Avion]  A     ON A.idavion = PAS.idavion
--JOIN [dbo].[Vuelo]  V     ON V.idavion = A.idavion

where   pasa.email='soyuruguayo@gmail.com' and YEAR(P.fecha)='2018' AND MONTH(P.fecha) = '9'













select DISTINCT  V.*
from pasajero PASA     
JOIN [dbo].[Pasaje]  PAS  ON PAS.idpasajero = PASA.idpasajero
JOIN [dbo].[Avion]  A     ON A.idavion = PAS.idavion
JOIN [dbo].[Vuelo]  V     ON V.idavion = A.idavion

where   pasa.email='soyuruguayo@gmail.com' --and pasa.email='soyuruguayo@gmail.com'
and exists (
				select *
				from pago
				where YEAR(fecha)='2018' AND MONTH(fecha) = '9'
				and pasa.idpasajero = idpasajero
			)
			





select * from Vuelo
select * from pago
select * from pasaje
 