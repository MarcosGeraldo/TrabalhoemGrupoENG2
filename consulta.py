import psycopg2
from datetime import date
import sys

conn = psycopg2.connect(
    host="localhost",
    database="tp",
    user="postgres",
    password="00726854"
)
c = conn.cursor()

def consultaCliente(data):
    c.execute(f'SELECT * FROM public.cliente WHERE CNH IN (SELECT contrato_cliente_CNH FROM public.contrato WHERE (data_expiracao >= date \'{data}\'))')
    resultado = c.fetchall()
    for row in resultado:
        print(row)
    return resultado

########################################### VEICULO #################################################
def cadastrarVeiculo(renavan,placa,blindado,num_passageiros,cap_bagageiro,modelo,veiculo_agencia_cnpj):
    c.execute(f' INSERT INTO public.veiculo (renavan,placa,blindado,num_passageiros,cap_bagageiro,modelo,veiculo_agencia_cnpj) VALUES (\'{renavan}\', \'{placa}\', {blindado}, {num_passageiros}, {cap_bagageiro}, \'{modelo}\', \'{veiculo_agencia_cnpj}\')')
    conn.commit()
    resultado = c.statusmessage
    if(resultado == 'INSERT 0 1'):
        print('Query returned successfully')
    else:
        print('Query not returned successfully')
    return resultado
def buscarVeiculo(renavan):
    i = 0
    c.execute(f'SELECT* FROM public.veiculo WHERE renavan = \'{renavan}\'')
    campo = c.description
    resultado = c.fetchall()
    for row in resultado:
        for elem in row:
            print(campo[i].name + ": " + str(elem))
            i += 1
    return resultado
def alterarVeiculo(renavan,alterar, op):
    if(op == 1):
        c.execute(f'UPDATE public.veiculo SET placa = \'{alterar}\' WHERE renavan = \'{renavan}\'')
    if(op == 2):
        c.execute(f'UPDATE public.veiculo SET blindado = \'{alterar}\' WHERE renavan = \'{renavan}\'')
    conn.commit()
    resultado = c.statusmessage
    if(resultado == 'UPDATE 1'):
        print('Query returned successfully')
    else:
        print('Query not returned successfully')
    return resultado
def removerVeiculo(renavan):
    c.execute(f'DELETE FROM veiculo WHERE renavan = \'{renavan}\'')
    conn.commit()
    resultado = c.statusmessage
    if(resultado == 'DELETE 1'):
        print('Query returned successfully')
    else:
        print('Query not returned successfully')
    return resultado
#####################################################################################################
########################################### CONTRATO ################################################
def criarContrato(num_contrato, quilometragem_final, forma_pagamento, data_inicio, data_expiracao, agencia_cnpj, cliente_cnh, renavan):
    c.execute(f'INSERT INTO public.contrato (numcontrato,quilometragem_final,forma_pagamento,data_inicio,data_expiracao,contrato_agencia_cnpj,contrato_cliente_cnh,contrato_veiculo_renavan) VALUES ({num_contrato}, {quilometragem_final}, \'{forma_pagamento}\', \'{data_inicio}\', \'{data_expiracao}\', \'{agencia_cnpj}\', \'{cliente_cnh}\', \'{renavan}\')')
    conn.commit()
    resultado = c.statusmessage
    print()
    if(resultado == 'INSERT 0 1'):
        print('Query returned successfully')
    else:
        print('Query not returned successfully')
    return resultado
def buscarContrato(num):
    i = 0
    c.execute(f'SELECT* FROM public.contrato WHERE numcontrato = {num}')
    campo = c.description
    resultado = c.fetchall()
    for row in resultado:
        for elem in row:
            print(campo[i].name + ": " + str(elem))
            i += 1
    return resultado
def alterarContrato(num,alterar,op):
    if(op == 1):
        c.execute(f'UPDATE public.contrato SET quilometragem_final = {alterar} WHERE numcontrato = \'{num}\'')
    if(op == 2):
        c.execute(f'UPDATE public.contrato SET forma_pagamento = \'{alterar}\' WHERE numcontrato = \'{num}\'')
    if(op == 3):
        c.execute(f'UPDATE public.contrato SET data_expiracao = \'{alterar}\' WHERE numcontrato = \'{num}\'')
    if(op == 4):
        c.execute(f'UPDATE public.contrato SET contrato_cliente_cnh = \'{alterar}\' WHERE numcontrato = \'{num}\'')
    conn.commit()
    resultado = c.statusmessage
    if(resultado == 'UPDATE 1'):
        print('Query returned successfully')
    else:
        print('Query not returned successfully')
    return resultado
def removerContrato(num):
    c.execute(f'DELETE FROM contrato WHERE numcontrato = \'{num}\'')
    conn.commit()
    resultado = c.statusmessage
    if(resultado == 'DELETE 1'):
        print('Query returned successfully')
    else:
        print('Query not returned successfully')
    return resultado
#####################################################################################################
########################################### FUNCIONÁRIO #############################################
def cadastrarFuncionario(cpf, sexo, nome, salário, data_nascimento, logradouro, cidade, número, bairro, cep, cnpj_agência):
    c.execute(f'INSERT INTO public.funcionario (cpf,sexo,nome,salario,data_nascimento,logradouro,cidade,numero,bairro,cep,funcionario_agencia_cnpj) VALUES (\'{cpf}\', \'{sexo}\', \'{nome}\', {salário}, \'{data_nascimento}\', \'{logradouro}\', \'{cidade}\', \'{número}\', \'{bairro}\', {cep}, \'{cnpj_agência}\')')
    conn.commit()
    resultado = c.statusmessage
    print()
    if(resultado == 'INSERT 0 1'):
        print('Query returned successfully')
    else:
        print('Query not returned successfully')
    return resultado
def buscarFuncionario(cpf):
    i = 0
    c.execute(f'SELECT* FROM public.funcionario WHERE cpf = \'{cpf}\'')
    campo = c.description
    resultado = c.fetchall()
    for row in resultado:
        for elem in row:
            print(campo[i].name + ": " + str(elem))
            i += 1
    return resultado
def alterarFuncionario(cpf,alterar,op):
    if(op == 1):
        c.execute(f'UPDATE public.funcionario SET salario = {alterar} WHERE cpf = \'{cpf}\'')
    if(op == 2):
        c.execute(f'UPDATE public.funcionario SET logradouro = \'{alterar}\' WHERE cpf = \'{cpf}\'')
    if(op == 3):
        c.execute(f'UPDATE public.funcionario SET cidade = \'{alterar}\' WHERE cpf = \'{cpf}\'')
    if(op == 4):
        c.execute(f'UPDATE public.funcionario SET numero = \'{alterar}\' WHERE cpf = \'{cpf}\'')
    if(op == 5):
        c.execute(f'UPDATE public.funcionario SET bairro = \'{alterar}\' WHERE cpf = \'{cpf}\'')
    if(op == 6):
        c.execute(f'UPDATE public.funcionario SET cep = {alterar} WHERE cpf = \'{cpf}\'')
    conn.commit()
    resultado = c.statusmessage
    if(resultado == 'UPDATE 1'):
        print('Query returned successfully')
    else:
        print('Query not returned successfully')
    return resultado
def removerFuncionario(cpf):
    c.execute(f'DELETE FROM funcionario WHERE cpf = \'{cpf}\'')
    conn.commit()
    resultado = c.statusmessage
    if(resultado == 'DELETE 1'):
        print('Query returned successfully')
    else:
        print('Query not returned successfully')
    return resultado
#####################################################################################################
def consultaPagamento(forma):
    c.execute(f'SELECT * FROM public.veiculo WHERE renavan IN (SELECT contrato_veiculo_renavan FROM public.contrato WHERE forma_pagamento = \'{forma}\')')
    resultado = c.fetchall()
    for row in resultado:
        print(row)
    return resultado

def consultaVeiculo(renavam):
    c.execute(f'SELECT COUNT(*) FROM public.contrato WHERE contrato_veiculo_renavan =\'{renavam}\'')
    resultado = c.fetchone()
    print(f'O veiculo de Renavam {renavam} foi utilizado {resultado} vezes em contratos')
    return resultado

def atualizaVeiculo(operacao,valor,plano):
    data = date.today()
    c.execute(f'UPDATE public.{plano} SET valor_{plano}=valor_{plano}{operacao}{valor} WHERE numcontrato_{plano} IN (SELECT numcontrato FROM contrato WHERE (data_expiracao >= date \'{data}\' AND contrato_veiculo_renavan IN (SELECT renavan FROM veiculo WHERE blindado = \'true\')))')
    conn.commit()
    print(f'Update de veiculos blindados em contratos do tipo \'{plano}\' realizado com sucesso !!!')

def main():
    op = 1
    dados = ""
    while(op > 0 and op < 6):
        print('\n\n 1-Gerenciar veículos')
        print('\n 2-Gerenciar contratos')
        print('\n 3-Gerenciar funcionários')
        print('\n 6-Sair')
        op = int(sys.stdin.readline())
        if op == 1:
            while(op > 0 and op < 5):
                print('\n\n 1-Cadastrar veículo')
                print('\n 2-Buscar veículo')
                print('\n 3-Alterar veículo')
                print('\n 4-Remover veículo')
                print('\n 5-voltar')
                op = int(sys.stdin.readline())
                if op == 1:
                    print('Entre com os valores de renavan, placa, blindado, num_passageiros, cap_bagageiro, modelo, veiculo_agencia_cnpj')
                    dados = str(sys.stdin.readline())
                    entradas = dados.split(", ")
                    cadastrarVeiculo(entradas[0],entradas[1],entradas[2],entradas[3],entradas[4],entradas[5],entradas[6].strip('\n'))
                if op == 2:
                    print('Digite o RENAVAN')
                    renavan = input()
                    buscarVeiculo(renavan)
                if op == 3:
                    print('Digite o RENAVAN')
                    renavan = input()
                    print('Escolha o campo a ser alterado')
                    print('\n 1-Placa')
                    print('\n 2-Blindado')
                    print('\n 3-voltar')
                    op = int(sys.stdin.readline())
                    if(op == 1):
                        print('Digite a nova placa')
                        placa = input()
                        alterarVeiculo(renavan,placa,op)
                    if(op == 2):
                        print('Digite a nova blindagem')
                        blindado = input()
                        alterarVeiculo(renavan,blindado,op)
                if op == 4:
                    print('Digite o RENAVAN')
                    renavan = input()
                    removerVeiculo(renavan)
        if op == 2:
            while(op > 0 and op < 4):
                print('\n\n 1-Criar contrato')
                print('\n 2-Buscar contrato')
                print('\n 3-Alterar contrato')
                print('\n 4-Remover contrato')
                print('\n 5-voltar')
                op = int(sys.stdin.readline())
                if op == 1:
                    print('Entre com numero do contrato, forma de pagamento, inicio, expiração, cnpj da agência, cnh cliente, renavan')
                    dados = str(sys.stdin.readline())
                    entradas = dados.split(", ")
                    criarContrato(entradas[0], 0, entradas[1], entradas[2], entradas[3], entradas[4], entradas[5], entradas[6].strip('\n'))
                if op == 2:
                    print('Digite o número do contrato')
                    num = input()
                    buscarContrato(num)
                if op == 3:
                    print('Digite o numero do contrato')
                    num = input()
                    print('Escolha o campo a ser alterado')
                    print('\n 1-Quilometragem final')
                    print('\n 2-Forma de pagamento')
                    print('\n 3-Data expiração')
                    print('\n 4-CNH cliente')
                    print('\n 5-voltar')
                    op = int(sys.stdin.readline())
                    if op == 1:
                        print('Digite a quilometragem final')
                        km = input()
                        alterarContrato(num,km,op)
                    if op == 2:
                        print('Digite a nova forma de pagamento')
                        pag = input()
                        alterarContrato(num,pag,op)
                    if op == 3:
                        print('Digite a nova data de expiração')
                        data = input()
                        alterarContrato(num,data,op)
                    if op == 4:
                        print('Digite a nova CNH')
                        cnh = input()
                        alterarContrato(num,cnh,op)
                if op == 4:
                    print('Digite o numero do contrato')
                    num = input()
                    removerContrato(num)
        if op == 3:
            while(op > 0 and op < 5):
                print('\n\n 1-Cadastrar funcionário')
                print('\n 2-Buscar funcionário')
                print('\n 3-Alterar funcionário')
                print('\n 4-Remover funcionário')
                print('\n 5-voltar')
                op = int(sys.stdin.readline())
                if op == 1:
                    print('Entre com os valores de cpf, sexo, nome, salário, data nascimento, logradouro, cidade, número, bairro, cep, cnpj agência')
                    dados = str(sys.stdin.readline())
                    entradas = dados.split(", ")
                    cadastrarFuncionario(entradas[0],entradas[1],entradas[2],entradas[3],entradas[4],entradas[5],entradas[6],entradas[7],entradas[8],entradas[9], entradas[10].strip('\n'))
                if op == 2:
                    print('Digite o CPF')
                    cpf = input()
                    buscarFuncionario(cpf)
                if op == 3:
                    print('Digite o CPF')
                    cpf = input()
                    print('Escolha o campo a ser alterado')
                    print('\n 1-Salário')
                    print('\n 2-Logradouro')
                    print('\n 3-Cidade')
                    print('\n 4-Número')
                    print('\n 5-Bairro')
                    print('\n 6-cep')
                    print('\n 7-voltar')
                    op = int(sys.stdin.readline())
                    if(op == 1):
                        print('Digite o novo salário')
                        salario = input()
                        alterarFuncionario(cpf,salario,op)
                    if(op == 2):
                        print('Digite o novo logradouro')
                        logradouro = input()
                        alterarFuncionario(cpf,logradouro,op)
                    if(op == 3):
                        print('Digite a nova cidade')
                        cidade = input()
                        alterarFuncionario(cpf,cidade,op)
                    if(op == 4):
                        print('Digite o novo número')
                        numero = input()
                        alterarFuncionario(cpf,numero,op)
                    if(op == 5):
                        print('Digite o novo bairro')
                        bairro = input()
                        alterarFuncionario(cpf,bairro,op)
                    if(op == 6):
                        print('Digite o novo cep')
                        cep = input()
                        alterarFuncionario(cpf,cep,op)
                if op == 4:
                    print('Digite o CPF')
                    cpf = input()
                    removerFuncionario(cpf)
    c.close()

if __name__ == '__main__':
    main()