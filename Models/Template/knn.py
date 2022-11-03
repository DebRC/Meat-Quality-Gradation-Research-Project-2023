#K-Nearest Neighbors (K-NN)  93% accurate

#	importing the	libraries
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

#	importing the dataset
DataSet = pd.read_csv('Social_Network_Ads.csv')
X = DataSet.iloc[:,[2,3]].values
Y = DataSet.iloc[:,4].values

# splitting the data set into Training set and Test Set
from sklearn.model_selection import train_test_split
X_train,X_test,Y_train,Y_test = train_test_split(X, Y, test_size=0.25, random_state=0)

#feature scaling
from sklearn.preprocessing import StandardScaler
sc =StandardScaler()
X_train = sc.fit_transform(X_train)
X_test = sc.transform(X_test)

# Fitting the classifier to training set
from sklearn.neighbors import KNeighborsClassifier
classifier = KNeighborsClassifier(n_neighbors=5, metric = 'minkowski', p=2)
classifier.fit(X_train,Y_train)

#predicting the test set results
Y_pred = classifier.predict(X_test)

#Making the Confusion Matrix
from sklearn.metrics import confusion_matrix
cm = confusion_matrix(Y_test,Y_pred)
print(cm)

#Visualising the training set results
from matplotlib.colors import ListedColormap
X_set , y_set = X_train ,Y_train
X1,X2 =  np.meshgrid(np.arange(start = X_set[: , 0].min() - 1, stop = X_set[: , 0].max() + 1,step = 0.01),
					 np.arange(start = X_set[: , 0].min() - 1, stop = X_set[: , 0].max() + 1,step = 0.01))
plt.contourf(X1,X2,classifier.predict(np.array([X1.ravel() , X2.ravel()]).T).reshape(X1.shape) ,
			 alpha = 0.75, cmap = ListedColormap(('khaki','greenyellow')))
plt.xlim(X1.min() , X1.max())
plt.ylim(X2.min() , X2.max())
for i,j in enumerate(np.unique(y_set)) :
	plt.scatter(X_set[y_set == j , 0], X_set[y_set == j , 1] , c = ListedColormap(('red','green'))(i), label =j)

plt.title('K-NN(Training Set)')
plt.xlabel('age')
plt.ylabel('Estimated Salary')
plt.legend()
plt.show()

#Visualising the test set results
from matplotlib.colors import ListedColormap
X_set , y_set = X_test ,Y_test
X1,X2 =  np.meshgrid(np.arange(start = X_set[: , 0].min() - 1, stop = X_set[: , 0].max() + 1,step = 0.01),
					 np.arange(start = X_set[: , 0].min() - 1, stop = X_set[: , 0].max() + 1,step = 0.01))
plt.contourf(X1,X2,classifier.predict(np.array([X1.ravel() , X2.ravel()]).T).reshape(X1.shape) ,
			 alpha = 0.75, cmap = ListedColormap(('khaki','greenyellow')))
plt.xlim(X1.min() , X1.max())
plt.ylim(X2.min() , X2.max())
for i,j in enumerate(np.unique(y_set)) :
	plt.scatter(X_set[y_set == j , 0], X_set[y_set == j , 1] , c = ListedColormap(('red','green'))(i), label =j)

plt.title('K-NN(Test Set)')
plt.xlabel('age')
plt.ylabel('Estimated Salary')
plt.legend()
plt.show()
