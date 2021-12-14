import unittest
from unittest import mock
import consulta

class unit_test_veiculo(unittest.TestCase):
    @mock.patch("psycopg2.connect")
    def test_1_cadastrarVeiculo(self,mock_connect):
        esperado = 'INSERT 0 1'

        mock_con = mock_connect.return_value  # result of psycopg2.connect(**connection_stuff)
        mock_cur = mock_con.cursor.return_value  # result of con.cursor(cursor_factory=DictCursor)
        mock_cur.fetchall.return_value = esperado  # return this when calling cur.fetchall()

        result = consulta.cadastrarVeiculo(111,'AAA',True,5,100,'teste','19702999998')
        self.assertEqual(result, esperado)   

    @mock.patch("psycopg2.connect")
    def test_2_buscarVeiculo(self,mock_connect):

        mock_con = mock_connect.return_value  # result of psycopg2.connect(**connection_stuff)
        mock_cur = mock_con.cursor.return_value  # result of con.cursor(cursor_factory=DictCursor)
        mock_cur.fetchall.return_value = 1  # return this when calling cur.fetchall()

        result = consulta.buscarVeiculo(111)
        self.assertTrue(len(result))  

    @mock.patch("psycopg2.connect")
    def test_3_alterarVeiculo(self,mock_connect):
        esperado = 'UPDATE 1'

        mock_con = mock_connect.return_value  # result of psycopg2.connect(**connection_stuff)
        mock_cur = mock_con.cursor.return_value  # result of con.cursor(cursor_factory=DictCursor)
        mock_cur.fetchall.return_value = esperado  # return this when calling cur.fetchall()

        result = consulta.alterarVeiculo(111, 'ABC', 1)
        self.assertEqual(result, esperado) 
        result2 = consulta.alterarVeiculo(111, False, 2)
        self.assertEqual(result2, esperado)      
    
    @mock.patch("psycopg2.connect")
    def test_4_removerVeiculo(self,mock_connect):
        esperado = 'DELETE 1'

        mock_con = mock_connect.return_value  # result of psycopg2.connect(**connection_stuff)
        mock_cur = mock_con.cursor.return_value  # result of con.cursor(cursor_factory=DictCursor)
        mock_cur.fetchall.return_value = esperado  # return this when calling cur.fetchall()

        result = consulta.removerVeiculo(111)
        self.assertEqual(result, esperado)     
    
class unit_test_contrato(unittest.TestCase):
        @mock.patch("psycopg2.connect")
        def test_1_criarContrato(self,mock_connect):
            esperado = 'INSERT 0 1'

            mock_con = mock_connect.return_value  # result of psycopg2.connect(**connection_stuff)
            mock_cur = mock_con.cursor.return_value  # result of con.cursor(cursor_factory=DictCursor)
            mock_cur.fetchall.return_value = esperado  # return this when calling cur.fetchall()

            result = consulta.criarContrato(1,10,'dinheiro','2021-10-10','2021-10-12','19702999998','88845612332','15468935712')
            self.assertEqual(result, esperado)   
        
        @mock.patch("psycopg2.connect")
        def test_2_buscarContrato(self,mock_connect):

            mock_con = mock_connect.return_value  # result of psycopg2.connect(**connection_stuff)
            mock_cur = mock_con.cursor.return_value  # result of con.cursor(cursor_factory=DictCursor)
            mock_cur.fetchall.return_value = 1  # return this when calling cur.fetchall()

            result = consulta.buscarContrato(1)
            self.assertTrue(len(result))  

        @mock.patch("psycopg2.connect")
        def test_3_alterarContrato(self,mock_connect):
            esperado = 'UPDATE 1'

            mock_con = mock_connect.return_value  # result of psycopg2.connect(**connection_stuff)
            mock_cur = mock_con.cursor.return_value  # result of con.cursor(cursor_factory=DictCursor)
            mock_cur.fetchall.return_value = esperado  # return this when calling cur.fetchall()

            result = consulta.alterarContrato(1, 100, 1)
            self.assertEqual(result, esperado) 
            result2 = consulta.alterarContrato(1, 'credito', 2)
            self.assertEqual(result2, esperado)      
            result3 = consulta.alterarContrato(1, '2021-10-14', 3)
            self.assertEqual(result3, esperado) 
            result4 = consulta.alterarContrato(1, '63087941156', 4)
            self.assertEqual(result4, esperado)   
        
        @mock.patch("psycopg2.connect")
        def test_4_removerContrato(self,mock_connect):
            esperado = 'DELETE 1'

            mock_con = mock_connect.return_value  # result of psycopg2.connect(**connection_stuff)
            mock_cur = mock_con.cursor.return_value  # result of con.cursor(cursor_factory=DictCursor)
            mock_cur.fetchall.return_value = esperado  # return this when calling cur.fetchall()

            result = consulta.removerContrato(1)
            self.assertEqual(result, esperado)   

class unit_test_Funcionario(unittest.TestCase):
        @mock.patch("psycopg2.connect")
        def test_1_cadastrarFuncionario(self,mock_connect):
            esperado = 'INSERT 0 1'

            mock_con = mock_connect.return_value  # result of psycopg2.connect(**connection_stuff)
            mock_cur = mock_con.cursor.return_value  # result of con.cursor(cursor_factory=DictCursor)
            mock_cur.fetchall.return_value = esperado  # return this when calling cur.fetchall()

            result = consulta.cadastrarFuncionario('1111111111', 'masculino', 'Lucas de Souza Silva', 10000, '1998-09-15', 'Felipe dos santos', 'OP', '110', 'Antônio Dias', '35400000', '19702999998')
            self.assertEqual(result, esperado)   
        
        @mock.patch("psycopg2.connect")
        def test_2_buscarFuncionario(self,mock_connect):

            mock_con = mock_connect.return_value  # result of psycopg2.connect(**connection_stuff)
            mock_cur = mock_con.cursor.return_value  # result of con.cursor(cursor_factory=DictCursor)
            mock_cur.fetchall.return_value = 1  # return this when calling cur.fetchall()

            result = consulta.buscarFuncionario(1111111111)
            self.assertTrue(len(result))  

        @mock.patch("psycopg2.connect")
        def test_3_alterarFuncionario(self,mock_connect):
            esperado = 'UPDATE 1'

            mock_con = mock_connect.return_value  # result of psycopg2.connect(**connection_stuff)
            mock_cur = mock_con.cursor.return_value  # result of con.cursor(cursor_factory=DictCursor)
            mock_cur.fetchall.return_value = esperado  # return this when calling cur.fetchall()

            result = consulta.alterarFuncionario(1111111111, 20000, 1)
            self.assertEqual(result, esperado) 
            result2 = consulta.alterarFuncionario(1111111111, 'Engenho da prata', 2)
            self.assertEqual(result2, esperado)      
            result3 = consulta.alterarFuncionario(1111111111, 'BH', 3)
            self.assertEqual(result3, esperado) 
            result4 = consulta.alterarFuncionario(1111111111, 132, 4)
            self.assertEqual(result4, esperado) 
            result5 = consulta.alterarFuncionario(1111111111, 'Engenho Nogueira', 5)
            self.assertEqual(result5, esperado)   
            result6 = consulta.alterarFuncionario(1111111111, 31320520, 6)
            self.assertEqual(result6, esperado)   
        
        @mock.patch("psycopg2.connect")
        def test_4_removerFuncionario(self,mock_connect):
            esperado = 'DELETE 1'

            mock_con = mock_connect.return_value  # result of psycopg2.connect(**connection_stuff)
            mock_cur = mock_con.cursor.return_value  # result of con.cursor(cursor_factory=DictCursor)
            mock_cur.fetchall.return_value = esperado  # return this when calling cur.fetchall()

            result = consulta.removerFuncionario(1111111111)
            self.assertEqual(result, esperado)

if __name__ == '__main__':
    unittest.main()
