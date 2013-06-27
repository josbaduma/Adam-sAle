select Oferta.PersonasMatriculadas, Oferta.Creditos,  Curso.CursoId, Curso.NombreCurso From Curso  inner join Oferta on Oferta.CursoId=Curso.CursoId and Oferta.PeriodoId = 2 
