static class Matrix{
  int rows,cols;
  double data[][];
//------------------------------------------------------------------------------
  Matrix(int rows,int cols)
  {
    this.rows=rows;
    this.cols=cols;
    data=new double[rows][cols];
  }
  //-----------------------------------------------------------------------------
  public static Matrix addScalar(Matrix a,float b){
    Matrix c=new Matrix(a.rows,a.cols);
    for(int i=0;i<a.rows;i++)
    {
        for(int j=0;j<a.cols;j++)
        {
            c.data[i][j]=a.data[i][j]+b;
        }
    }
    return c;
  }
//-------------------------------------------------------------------------------
  public static Matrix multiplyScalar(Matrix a,double b){
    
    
    Matrix c=new Matrix(a.rows,a.cols);
    for(int i=0;i<a.rows;i++)
    {
        for(int j=0;j<a.cols;j++)
        {
          c.data[i][j]=a.data[i][j]*b;
        }
    }
    return c;
    
  }
//-------------------------------------------------------------------------------
public static Matrix transpose(Matrix a){
  Matrix c=new Matrix(a.cols,a.rows);
  for(int i=0;i<a.rows;i++){
    for(int j=0;j<a.cols;j++){
      c.data[j][i]=a.data[i][j];
    }
  }
  return c;
}
//-------------------------------------------------------------------------------
public static Matrix Multiply(Matrix a,Matrix b){
  Matrix c=new Matrix(a.rows,b.cols);
  for(int i=0;i<a.rows;i++)
  {
    for(int j=0;j<b.cols;j++)
    {
        float sum=0;
        for(int k=0;k<a.cols;k++)
        {
           sum+=a.data[i][k]*b.data[k][j];
        }
        c.data[i][j]=sum;
    }
    
  }
  return c;

}
//----------------------------------------------------------------------------------

public void printMatrix()
{
    print("printing a matrix\n");
    for(int i=0;i<this.rows;i++)
    {
        for(int j=0;j<this.cols;j++)
        {
            print(this.data[i][j]+" ");
        }
        println(" ");
    }
     println(" ");
}
//------------------------------------------------------------------------
public void randomize(){
  for(int i=0;i<this.rows;i++)
  {
      for(int j=0;j<this.cols;j++)
      {
          this.data[i][j]=2*Math.random()-1;
      }
  }
}
//------------------------------------------------------------------
public static Matrix HadamardMultiply(Matrix a,Matrix b){
  Matrix c=new Matrix(a.rows,a.cols);
  for(int i=0;i<a.rows;i++)
  {
     for(int j=0;j<a.cols;j++){
       c.data[i][j]=a.data[i][j]*b.data[i][j];
     }
  }
  return c;
}
//-----------------------------------------------------------------------
public static double[] toArray(Matrix a){
  double[] array=new double[a.rows*a.cols];
  int k=0;
  for(int i=0;i<a.rows;i++)
  {
      for(int j=0;j<a.cols;j++)
      {
          array[k++]=a.data[i][j];
      }
  }
  return array;
}
//-------------------------------------------------------------------------
public static Matrix fromArray(double[] inputs){
  Matrix c=new Matrix(inputs.length,1);
  for(int i=0;i<inputs.length;i++)
  {
      c.data[i][0]=inputs[i];
  }
  return c;
}
//----------------------------------------------------------------------------
public static Matrix Add(Matrix a,Matrix b){
  Matrix c=new Matrix(a.rows,a.cols);
  for(int i=0;i<a.rows;i++){
      for(int j=0;j<a.cols;j++){
          c.data[i][j]=a.data[i][j]+b.data[i][j];
      }
  }
  return c;
}
//--------------------------------------------------------------------------------------
public static Matrix ApplySigmoid(Matrix a){
  Matrix c=new Matrix(a.rows,a.cols);
  for(int i=0;i<a.rows;i++)
  {
      for(int j=0;j<a.cols;j++)
      {
          c.data[i][j]=sigmoid(a.data[i][j]);
      }
  }
  return c;
  
}
//-------------------------------------------------------------------------
public static Matrix Subtract(Matrix a,Matrix b){
    Matrix c=new Matrix(a.rows,a.cols);
    for(int i=0;i<a.rows;i++){
        for(int j=0;j<a.cols;j++){
          c.data[i][j]=a.data[i][j]-b.data[i][j];
        }
    }
    return c;
}
//-------------------------------------------------------------------------
public static double sigmoid(double x){
      return 1/(1+Math.pow(Math.E,(-1*x)));
}
//------------------------------------------------------------------------
public static Matrix dfSigmoid(Matrix a){
   Matrix c=new Matrix(a.rows,a.cols);
  for(int i=0;i<a.rows;i++)
  {
      for(int j=0;j<a.cols;j++)
      {
          c.data[i][j]=derivative(a.data[i][j]);
      }
  }
  return c;
}
//------------------------------------------------------------------------
public static double derivative(double x){
  return x*(1-x);
}
//-----------------------------------------------------------------------

}
