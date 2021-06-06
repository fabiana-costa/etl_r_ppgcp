situacao_aluno <- c(1, 1, 2, 1, 1, 1, 4, 1, 5, 3, 1, 2)

recode <- c (matriculado = 1, trancamento = 2, desistencia = 3, transferencia = 4, desvinculado = 5)

(situacao_aluno <- factor(situacao_aluno, levels = recode, labels = names(recode)))

