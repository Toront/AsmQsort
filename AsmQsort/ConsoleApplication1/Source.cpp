/*4.������� ������� - 2,1 � 0. ��������� ������� 0, ����� 1� 2.*/
#include <iostream>
#include <ctime>
#include <windows.h>
#include <cstdlib>
using namespace std;
extern "C" void QS(int* , int*);

int main() {
	srand(time(NULL));
	static int *massiv, n, k;
	system("chcp 1251");
	cout << "������� ������ �������: ";
	cin >> n;
	massiv = new int[n];
	for (int i = 0; i<n; i++) {
		massiv[i] = rand() % 3;
		cout << massiv[i] << " ";
	}
	QS(&massiv[0], &massiv[n-1]);
	cout << endl << endl << "SORT:"<<endl;
	for (int i = 0; i < n; i++)
		cout << massiv[i] << " ";
	
	cout << endl;
	system("pause");

	return 0;
}