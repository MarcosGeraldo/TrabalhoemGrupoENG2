-- -----------------------------------------------------
-- Table public.agencia
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.agencia (
  cnpj_agencia VARCHAR(14) NOT NULL,
  num_funcionario INT NOT NULL,
  num_parceiros INT NOT NULL,
  num_veiculos INT NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  bairro VARCHAR(45) NOT NULL,
  lograudoro VARCHAR(45) NOT NULL,
  numero INT NOT NULL,
  cep INT NOT NULL,
  PRIMARY KEY (cnpj_agencia));



-- -----------------------------------------------------
-- Table public.funcionario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.funcionario (
  CPF VARCHAR(11) NOT NULL,
  sexo VARCHAR(10) NOT NULL,
  nome VARCHAR(60) NOT NULL,
  salario FLOAT NOT NULL,
  data_nascimento DATE NOT NULL,
  logradouro VARCHAR(45) NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  numero VARCHAR(45) NOT NULL,
  bairro VARCHAR(45) NOT NULL,
  cep INT NOT NULL,
  funcionario_agencia_cnpj VARCHAR(14) NOT NULL,
  PRIMARY KEY (CPF),
  CONSTRAINT fk_funcionario_agencia
    FOREIGN KEY (funcionario_agencia_cnpj)
    REFERENCES public.agencia (cnpj_agencia)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.atendente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.atendente (
  CPF_atendente VARCHAR(11) NOT NULL,
  comissao FLOAT NOT NULL,
  PRIMARY KEY (CPF_atendente),
  CONSTRAINT fk_cpf_atendente
    FOREIGN KEY (CPF_atendente)
    REFERENCES public.funcionario (CPF)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.cliente (
  CNH VARCHAR(11) NOT NULL,
  email VARCHAR(45) NOT NULL,
  nome VARCHAR(45) NOT NULL,
  logradouro VARCHAR(45) NOT NULL,
  bairro VARCHAR(45) NOT NULL,
  numero VARCHAR(45) NOT NULL,
  avaliacao_atendente INT NOT NULL,
  cliente_CPF_atendente VARCHAR(11) NULL,
  PRIMARY KEY (CNH),
  CONSTRAINT fk_cliente_atendente
    FOREIGN KEY (cliente_CPF_atendente)
    REFERENCES public.atendente (CPF_atendente)
    ON DELETE SET NULL
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.veiculo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.veiculo (
  renavan VARCHAR(20) NOT NULL,
  placa VARCHAR(45) NOT NULL,
  blindado BOOLEAN NOT NULL,
  num_passageiros INT NOT NULL,
  cap_bagageiro INT NOT NULL,
  modelo VARCHAR(45) NOT NULL,
  veiculo_agencia_cnpj VARCHAR(14) NULL,
  PRIMARY KEY (renavan),
  CONSTRAINT fk_veiculo_agencia
    FOREIGN KEY (veiculo_agencia_cnpj)
    REFERENCES public.agencia (cnpj_agencia)
    ON DELETE SET NULL
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.gerente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.gerente (
  CPF_gerente VARCHAR(11) NOT NULL,
  comissao FLOAT NOT NULL,
  PRIMARY KEY (CPF_gerente),
  CONSTRAINT fk_cpf_gerente
    FOREIGN KEY (CPF_gerente)
    REFERENCES public.funcionario (CPF)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.frotista
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.frotista (
  tipo_carteira VARCHAR(2) NOT NULL,
  CPF_frotista VARCHAR(11) NOT NULL,
  PRIMARY KEY (CPF_frotista),
  CONSTRAINT fk_cpf_frotista
    FOREIGN KEY (CPF_frotista)
    REFERENCES public.funcionario (CPF)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.parceiros
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.parceiros (
  razao_social VARCHAR(45) NOT NULL,
  logradouro VARCHAR(45) NOT NULL,
  numero INT NOT NULL,
  bairro VARCHAR(45) NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  cep INT NOT NULL,
  cnpj_parceiros VARCHAR(14) NOT NULL,
  PRIMARY KEY (cnpj_parceiros));



-- -----------------------------------------------------
-- Table public.oficina_mecanina
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.oficina_mecanina (
  cnpj_oficina VARCHAR(14) NOT NULL,
  gerente_responsavel VARCHAR(60) NOT NULL,
  PRIMARY KEY (cnpj_oficina),
  CONSTRAINT fk_cnpj_oficina
    FOREIGN KEY (cnpj_oficina)
    REFERENCES public.parceiros (cnpj_parceiros)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.posto_gasolina
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.posto_gasolina (
  cnpj_posto VARCHAR(14) NOT NULL,
  num_bombas INT NOT NULL,
  PRIMARY KEY (cnpj_posto),
  CONSTRAINT fk_cnpj_posto
    FOREIGN KEY (cnpj_posto)
    REFERENCES public.parceiros (cnpj_parceiros)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.lava_jato
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.lava_jato (
  cnpj_lava_jato VARCHAR(14) NOT NULL,
  gerente_lava_jato VARCHAR(30) NOT NULL,
  PRIMARY KEY (cnpj_lava_jato),
  CONSTRAINT fk_cnpj_lava_jato
    FOREIGN KEY (cnpj_lava_jato)
    REFERENCES public.parceiros (cnpj_parceiros)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.contrato
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.contrato (
  numContrato INT NOT NULL,
  quilometragem_final FLOAT NOT NULL,
  forma_pagamento VARCHAR(15) NOT NULL,
  data_inicio DATE NOT NULL,
  data_expiracao DATE NOT NULL,
  contrato_agencia_cnpj VARCHAR(14) NOT NULL,
  contrato_cliente_CNH VARCHAR(11) NOT NULL,
  contrato_veiculo_renavan VARCHAR(20) NOT NULL,
  PRIMARY KEY (numContrato),
  CONSTRAINT fk_contrato_agencia
    FOREIGN KEY (contrato_agencia_cnpj)
    REFERENCES public.agencia (cnpj_agencia)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_contrato_cliente
    FOREIGN KEY (contrato_cliente_CNH)
    REFERENCES public.cliente (CNH)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_contrato_veiculo
    FOREIGN KEY (contrato_veiculo_renavan)
    REFERENCES public.veiculo (renavan)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.eventual
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.eventual (
  numContrato_eventual INT NOT NULL,
  valor_diario FLOAT NOT NULL,
  qnt_max_extensoes INT NOT NULL,
  PRIMARY KEY (numContrato_eventual),
  CONSTRAINT fk_numContrato_eventual
    FOREIGN KEY (numContrato_eventual)
    REFERENCES public.contrato (numContrato)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.semanal
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.semanal (
  numContrato_semanal INT NOT NULL,
  limite_km FLOAT NOT NULL,
  valor_semanal FLOAT NOT NULL,
  PRIMARY KEY (numContrato_semanal),
  CONSTRAINT fk_numContrato_semanal
    FOREIGN KEY (numContrato_semanal)
    REFERENCES public.contrato (numContrato)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.mensal
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.mensal (
  numContrato_mensal INT NOT NULL,
  limite_km FLOAT NOT NULL,
  valor_mensal FLOAT NOT NULL,
  valor_seguro FLOAT NOT NULL,
  PRIMARY KEY (numContrato_mensal),
  CONSTRAINT fk_numContrato_mensal
    FOREIGN KEY (numContrato_mensal)
    REFERENCES public.contrato (numContrato)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.anual
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.anual (
  numContrato_anual INT NOT NULL,
  valor_anual FLOAT NOT NULL,
  porcentagem_ipva FLOAT NOT NULL,
  limite_km FLOAT NOT NULL,
  valor_seguro FLOAT NOT NULL,
  PRIMARY KEY (numContrato_anual),
  CONSTRAINT fk_numContrato_anual
    FOREIGN KEY (numContrato_anual)
    REFERENCES public.contrato (numContrato)
    ON DELETE CASCADE
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.conserta
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.conserta (
  conserta_cnpj_oficina VARCHAR(14) NOT NULL,
  conserta_veiculo_renavan VARCHAR(20) NOT NULL,
  itens_consertados VARCHAR(45) NOT NULL,
  data DATE NOT NULL,
  valor FLOAT NOT NULL,
  PRIMARY KEY (conserta_cnpj_oficina, conserta_veiculo_renavan),
  CONSTRAINT fk_cnpj_oficina_conserta
    FOREIGN KEY (conserta_cnpj_oficina)
    REFERENCES public.oficina_mecanina (cnpj_oficina)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_renavan_veiculo_conserta
    FOREIGN KEY (conserta_veiculo_renavan)
    REFERENCES public.veiculo (renavan)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.abastece
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.abastece (
  abastece_veiculo_renavan VARCHAR(20) NOT NULL,
  abastece_cnpj_posto VARCHAR(14) NOT NULL,
  litros_combustivel INT NOT NULL,
  valor_litro FLOAT NOT NULL,
  data DATE NOT NULL,
  PRIMARY KEY (abastece_veiculo_renavan, abastece_cnpj_posto),
  CONSTRAINT fk_veiculo_renavan_abastece
    FOREIGN KEY (abastece_veiculo_renavan)
    REFERENCES public.veiculo (renavan)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_cnpj_posto_gasolina
    FOREIGN KEY (abastece_cnpj_posto)
    REFERENCES public.posto_gasolina (cnpj_posto)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.abastece
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.abastece (
  abastece_veiculo_renavan VARCHAR(20) NOT NULL,
  abastece_cnpj_posto VARCHAR(14) NOT NULL,
  litros_combustivel INT NOT NULL,
  valor_litro FLOAT NOT NULL,
  data DATE NOT NULL,
  PRIMARY KEY (abastece_veiculo_renavan, abastece_cnpj_posto),
  CONSTRAINT fk_veiculo_renavan_abastece
    FOREIGN KEY (abastece_veiculo_renavan)
    REFERENCES public.veiculo (renavan)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_cnpj_posto_gasolina
    FOREIGN KEY (abastece_cnpj_posto)
    REFERENCES public.posto_gasolina (cnpj_posto)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.lava
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.lava (
  lava_cnpj_lava_jato VARCHAR(14) NOT NULL,
  lava_veiculo_renavan VARCHAR(20) NOT NULL,
  data DATE NOT NULL,
  valor FLOAT NOT NULL,
  PRIMARY KEY (lava_cnpj_lava_jato, lava_veiculo_renavan),
  CONSTRAINT fk_cnpj_lava_jato_lava
    FOREIGN KEY (lava_cnpj_lava_jato)
    REFERENCES public.lava_jato (cnpj_lava_jato)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_veiculo_renavan_lava
    FOREIGN KEY (lava_veiculo_renavan)
    REFERENCES public.veiculo (renavan)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.tem_parceria
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.tem_parceria (
  temparceria_agencia_cnpj VARCHAR(14) NOT NULL,
  temparceria_parceiros_cnpj VARCHAR(14) NOT NULL,
  PRIMARY KEY (temparceria_agencia_cnpj, temparceria_parceiros_cnpj),
  CONSTRAINT fk_cnpj_agencia_temparceria
    FOREIGN KEY (temparceria_agencia_cnpj)
    REFERENCES public.agencia (cnpj_agencia)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_cnpj_parceiro_temparceria
    FOREIGN KEY (temparceria_parceiros_cnpj)
    REFERENCES public.parceiros (cnpj_parceiros)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);



-- -----------------------------------------------------
-- Table public.cuida
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.cuida (
  cuida_CPF_frotista VARCHAR(11) NOT NULL,
  cuida_veiculo_renavan VARCHAR(11) NOT NULL,
  data_inicio DATE NOT NULL,
  data_termino DATE NOT NULL,
  PRIMARY KEY (cuida_CPF_frotista, cuida_veiculo_renavan),
  CONSTRAINT fk_cuida_cpf_frotista
    FOREIGN KEY (cuida_CPF_frotista)
    REFERENCES public.frotista (CPF_frotista)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_cuida_veiculo_renavan
    FOREIGN KEY (cuida_veiculo_renavan)
    REFERENCES public.veiculo (renavan)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Data for table public.agencia
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.agencia (cnpj_agencia, num_funcionario, num_parceiros, num_veiculos, cidade, bairro, lograudoro, numero, cep) VALUES ('19702999998', 6, 6, 5, 'Teixeiras', 'Centro', 'rua joao da silva', 449, 36580000);

COMMIT;


-- -----------------------------------------------------
-- Data for table public.funcionario
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.funcionario (CPF, sexo, nome, salario, data_nascimento, logradouro, cidade, numero, bairro, cep, funcionario_agencia_cnpj) VALUES ('44411122287', 'masculino', 'caio', 2500, '1997-12-02', 'rua osvaldo coelho', 'varginha', '78', 'centro', 87444000, '19702999998');
INSERT INTO public.funcionario (CPF, sexo, nome, salario, data_nascimento, logradouro, cidade, numero, bairro, cep, funcionario_agencia_cnpj) VALUES ('11158966622', 'feminino', 'vanessa', 5000, '1989-08-25', 'rua X29', 'curitiba', '254', 'centro', 66987000, '19702999998');
INSERT INTO public.funcionario (CPF, sexo, nome, salario, data_nascimento, logradouro, cidade, numero, bairro, cep, funcionario_agencia_cnpj) VALUES ('22266698755', 'masculino', 'pedro', 2900, '1988-03-24', 'avenida marechal', 'ouro preto', '69', 'centro', 54780000, '19702999998');
INSERT INTO public.funcionario (CPF, sexo, nome, salario, data_nascimento, logradouro, cidade, numero, bairro, cep, funcionario_agencia_cnpj) VALUES ('02345871299', 'feminino', 'ana clara', 5000, '1995-08-30', 'rua padre pedro', 'mariana', '9', 'centro', 12550000, '19702999998');
INSERT INTO public.funcionario (CPF, sexo, nome, salario, data_nascimento, logradouro, cidade, numero, bairro, cep, funcionario_agencia_cnpj) VALUES ('55436977712', 'masculino', 'joao pedro', 6000, '1996-10-22', 'rua alvarenga', 'coimbra', '23', 'centro', 47855000, '19702999998');
INSERT INTO public.funcionario (CPF, sexo, nome, salario, data_nascimento, logradouro, cidade, numero, bairro, cep, funcionario_agencia_cnpj) VALUES ('66987456932', 'feminino', 'poliana', 1500, '1998-03-02', 'rua permio fialho', 'teixeiras', '876', 'centro', 55896000, '19702999998');

COMMIT;


-- -----------------------------------------------------
-- Data for table public.atendente
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.atendente (CPF_atendente, comissao) VALUES ('11158966622', 20);
INSERT INTO public.atendente (CPF_atendente, comissao) VALUES ('55436977712', 30);

COMMIT;


-- -----------------------------------------------------
-- Data for table public.cliente
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.cliente (CNH, email, nome, logradouro, bairro, numero, avaliacao_atendente, cliente_CPF_atendente) VALUES ('55478931425', 'lucas@email.com', 'lucas', 'rua jeremias ', 'centro', '457', 8, '11158966622');
INSERT INTO public.cliente (CNH, email, nome, logradouro, bairro, numero, avaliacao_atendente, cliente_CPF_atendente) VALUES ('63087941156', 'cleber@email.com', 'cleber', 'rua cleber', 'centro', '902', 5, '11158966622');
INSERT INTO public.cliente (CNH, email, nome, logradouro, bairro, numero, avaliacao_atendente, cliente_CPF_atendente) VALUES ('88845612332', 'clara@email.com', 'clara', 'rua 14', 'centro', '54', 9, '11158966622');

COMMIT;


-- -----------------------------------------------------
-- Data for table public.veiculo
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.veiculo (renavan, placa, blindado, num_passageiros, cap_bagageiro, modelo, veiculo_agencia_cnpj) VALUES ('66689712425', 'MGX9987', 0, 4, 124, 'modeloA', '19702999998');
INSERT INTO public.veiculo (renavan, placa, blindado, num_passageiros, cap_bagageiro, modelo, veiculo_agencia_cnpj) VALUES ('15468935712', 'SPA6524', 1, 5, 300, 'modeloB', '19702999998');
INSERT INTO public.veiculo (renavan, placa, blindado, num_passageiros, cap_bagageiro, modelo, veiculo_agencia_cnpj) VALUES ('45788932566', 'XXX9077', 1, 2, 200, 'modeloC', '19702999998');
INSERT INTO public.veiculo (renavan, placa, blindado, num_passageiros, cap_bagageiro, modelo, veiculo_agencia_cnpj) VALUES ('54781145390', 'POO4444', 1, 5, 178, 'modeloD', '19702999998');
INSERT INTO public.veiculo (renavan, placa, blindado, num_passageiros, cap_bagageiro, modelo, veiculo_agencia_cnpj) VALUES ('32165498778', 'KLW9755', 0, 5, 230, 'modeloE', '19702999998');

COMMIT;


-- -----------------------------------------------------
-- Data for table public.gerente
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.gerente (CPF_gerente, comissao) VALUES ('22266698755', 45);
INSERT INTO public.gerente (CPF_gerente, comissao) VALUES ('66987456932', 50);

COMMIT;


-- -----------------------------------------------------
-- Data for table public.frotista
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.frotista (tipo_carteira, CPF_frotista) VALUES ('AB', '44411122287');
INSERT INTO public.frotista (tipo_carteira, CPF_frotista) VALUES ('C', '02345871299');

COMMIT;


-- -----------------------------------------------------
-- Data for table public.parceiros
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.parceiros (razao_social, logradouro, numero, bairro, cidade, cep, cnpj_parceiros) VALUES ('ABC lava jato', 'rua otavio costa', 772, 'centro', 'varginha', 55670000, '19498999905');
INSERT INTO public.parceiros (razao_social, logradouro, numero, bairro, cidade, cep, cnpj_parceiros) VALUES ('BD combustiveis', 'rua potassio', 555, 'centro', 'viçosa', 39879000, '19499999950');
INSERT INTO public.parceiros (razao_social, logradouro, numero, bairro, cidade, cep, cnpj_parceiros) VALUES ('XT mecanica', 'rua kovaski', 12, 'centro', 'coimbra', 45778000, '19500999946');
INSERT INTO public.parceiros (razao_social, logradouro, numero, bairro, cidade, cep, cnpj_parceiros) VALUES ('BAVARIA lava jato', 'rua otavio costa', 773, 'centro', 'varginha', 55670000, '19515999904');
INSERT INTO public.parceiros (razao_social, logradouro, numero, bairro, cidade, cep, cnpj_parceiros) VALUES ('Dois Irmaos Combustiveis', 'rua boro', 55, 'centro', 'guaraciaba', 12354000, '19513999915');
INSERT INTO public.parceiros (razao_social, logradouro, numero, bairro, cidade, cep, cnpj_parceiros) VALUES ('ZW mecanica', 'rua kovaski', 33, 'centro', 'coimbra', 69847000, '19570999902');

COMMIT;


-- -----------------------------------------------------
-- Data for table public.oficina_mecanina
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.oficina_mecanina (cnpj_oficina, gerente_responsavel) VALUES ('19500999946', 'valdecir');
INSERT INTO public.oficina_mecanina (cnpj_oficina, gerente_responsavel) VALUES ('19570999902', 'osvaldo');

COMMIT;


-- -----------------------------------------------------
-- Data for table public.posto_gasolina
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.posto_gasolina (cnpj_posto, num_bombas) VALUES ('19499999950', 4);
INSERT INTO public.posto_gasolina (cnpj_posto, num_bombas) VALUES ('19513999915', 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table public.lava_jato
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.lava_jato (cnpj_lava_jato, gerente_lava_jato) VALUES ('19498999905', 'diana');
INSERT INTO public.lava_jato (cnpj_lava_jato, gerente_lava_jato) VALUES ('19515999904', 'valmir');

COMMIT;


-- -----------------------------------------------------
-- Data for table public.contrato
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.contrato (numContrato, quilometragem_final, forma_pagamento, data_inicio, data_expiracao, contrato_agencia_cnpj, contrato_cliente_CNH, contrato_veiculo_renavan) VALUES (458, 54200, 'dinheiro', '2021-03-02', '2021-04-02', '19702999998', '55478931425', '66689712425');
INSERT INTO public.contrato (numContrato, quilometragem_final, forma_pagamento, data_inicio, data_expiracao, contrato_agencia_cnpj, contrato_cliente_CNH, contrato_veiculo_renavan) VALUES (100, 2540, 'credito', '2021-01-01', '2022-02-01', '19702999998', '88845612332', '32165498778');
INSERT INTO public.contrato (numContrato, quilometragem_final, forma_pagamento, data_inicio, data_expiracao, contrato_agencia_cnpj, contrato_cliente_CNH, contrato_veiculo_renavan) VALUES (120, 99988, 'dinheiro', '2021-01-01', '2021-01-02', '19702999998', '63087941156', '15468935712');
INSERT INTO public.contrato (numContrato, quilometragem_final, forma_pagamento, data_inicio, data_expiracao, contrato_agencia_cnpj, contrato_cliente_CNH, contrato_veiculo_renavan) VALUES (548, 50000, 'credito', '2021-03-03', '2021-03-10', '19702999998', '63087941156', '54781145390');

COMMIT;


-- -----------------------------------------------------
-- Data for table public.eventual
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.eventual (numContrato_eventual, valor_diario, qnt_max_extensoes) VALUES (120, 100, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table public.semanal
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.semanal (numContrato_semanal, limite_km, valor_semanal) VALUES (548, 589245, 1500);

COMMIT;


-- -----------------------------------------------------
-- Data for table public.mensal
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.mensal (numContrato_mensal, limite_km, valor_mensal, valor_seguro) VALUES (458, 10000, 589, 210);

COMMIT;


-- -----------------------------------------------------
-- Data for table public.anual
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.anual (numContrato_anual, valor_anual, porcentagem_ipva, limite_km, valor_seguro) VALUES (100, 489965, 12, 300000, 154);

COMMIT;


-- -----------------------------------------------------
-- Data for table public.conserta
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.conserta (conserta_cnpj_oficina, conserta_veiculo_renavan, itens_consertados, data, valor) VALUES ('19500999946', '45788932566', 'motor, troca de oleo', '2021-05-04', 998);
INSERT INTO public.conserta (conserta_cnpj_oficina, conserta_veiculo_renavan, itens_consertados, data, valor) VALUES ('19500999946', '32165498778', 'troca de oleo, martelinho de ouro', '2021-05-05', 700);
INSERT INTO public.conserta (conserta_cnpj_oficina, conserta_veiculo_renavan, itens_consertados, data, valor) VALUES ('19570999902', '66689712425', 'pintura, motor, pneus', '2021-06-03', 1350);
INSERT INTO public.conserta (conserta_cnpj_oficina, conserta_veiculo_renavan, itens_consertados, data, valor) VALUES ('19570999902', '15468935712', 'troca de escapamento, pneus e lataria', '2021-06-05', 1140);

COMMIT;


-- -----------------------------------------------------
-- Data for table public.abastece
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.abastece (abastece_veiculo_renavan, abastece_cnpj_posto, litros_combustivel, valor_litro, data) VALUES ('15468935712', '19499999950', 40, 4, '2021-04-05');
INSERT INTO public.abastece (abastece_veiculo_renavan, abastece_cnpj_posto, litros_combustivel, valor_litro, data) VALUES ('32165498778', '19499999950', 20, 5, '2021-04-09');
INSERT INTO public.abastece (abastece_veiculo_renavan, abastece_cnpj_posto, litros_combustivel, valor_litro, data) VALUES ('66689712425', '19513999915', 10, 5, '2021-04-03');
INSERT INTO public.abastece (abastece_veiculo_renavan, abastece_cnpj_posto, litros_combustivel, valor_litro, data) VALUES ('54781145390', '19513999915', 60, 6, '2021-04-07');

COMMIT;


-- -----------------------------------------------------
-- Data for table public.lava
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.lava (lava_cnpj_lava_jato, lava_veiculo_renavan, data, valor) VALUES ('19498999905', '54781145390', '2021-10-07', 80);
INSERT INTO public.lava (lava_cnpj_lava_jato, lava_veiculo_renavan, data, valor) VALUES ('19498999905', '45788932566', '2021-10-09', 90);
INSERT INTO public.lava (lava_cnpj_lava_jato, lava_veiculo_renavan, data, valor) VALUES ('19498999905', '66689712425', '2021-10-15', 80);
INSERT INTO public.lava (lava_cnpj_lava_jato, lava_veiculo_renavan, data, valor) VALUES ('19515999904', '54781145390', '2021-10-08', 110);
INSERT INTO public.lava (lava_cnpj_lava_jato, lava_veiculo_renavan, data, valor) VALUES ('19515999904', '32165498778', '2021-10-13', 150);

COMMIT;


-- -----------------------------------------------------
-- Data for table public.tem_parceria
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.tem_parceria (temparceria_agencia_cnpj, temparceria_parceiros_cnpj) VALUES ('19702999998', '19500999946');
INSERT INTO public.tem_parceria (temparceria_agencia_cnpj, temparceria_parceiros_cnpj) VALUES ('19702999998', '19515999904');
INSERT INTO public.tem_parceria (temparceria_agencia_cnpj, temparceria_parceiros_cnpj) VALUES ('19702999998', '19513999915');

COMMIT;


-- -----------------------------------------------------
-- Data for table public.cuida
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO public.cuida (cuida_CPF_frotista, cuida_veiculo_renavan, data_inicio, data_termino) VALUES ('44411122287', '66689712425', '2021-03-01', '2021-03-08');
INSERT INTO public.cuida (cuida_CPF_frotista, cuida_veiculo_renavan, data_inicio, data_termino) VALUES ('02345871299', '32165498778', '2021-03-15', '2021-03-20');

COMMIT;

