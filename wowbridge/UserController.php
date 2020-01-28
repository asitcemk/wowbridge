<?php

class UserController extends ShopController {

    /**
     * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
     * using two-column layout. See 'protected/views/layouts/column2.php'.
     */
    protected function columns() {

        return array(
              array(
                'name' => 'image',
                'type' => 'raw',
                'value' => 'CHtml::image(Yii::app()->request->baseUrl."/uploads/profile_image/pr.jpeg", "Image",
                array(\'width\'=>30, \'height\'=>40))',
            ),
            array(
                'name' => 'name',
                'value' => '$data->name',
            ),
             array(
                'name' => 'NAME',
                'value' => 'CHtml::activeTextField($data, "[$row]name")',
                'type' => 'raw',
            ),
         
            array(
                'name' => 'email',
                'type' => 'raw', // to encode html string
                'value' => '$data->email',
            ),
            array(
                'name' => 'create date',
                'value' => 'date("Y-m-d",strtotime($data->created_at))',
            ),
             array(
                'name' => 'Status',
                'type' => 'raw',
                'value' => '($data->status==1)?CHtml::tag("span",array("class"=>"label-success label label-default"),"Active"):CHtml::tag("span",array("class"=>"label-warning label label-default"),"Inactive")',
            ),
            array('class' => 'CButtonColumn',
                'template' => '{view} {update} {delete}',
                'buttons' => array(   
                     'view' => array(
                        'options' => array('class' => 'btn btn-success btn-sm','title'=>'Details'),
                        'label' => '<i class="glyphicon glyphicon-eye-open"></i> View',
                        'imageUrl' => false,
                    ),
                    'update' => array(
                        'label' => '<i class="glyphicon glyphicon-edit icon-white"></i> Edit',
                        'imageUrl' => false,
                        'options' => array('class' => 'btn btn-info btn-sm','title'=>'Edit'),
                    ),                   
                    'delete' => array(
                        'label' => '<i class="glyphicon glyphicon-trash icon-white"></i> Delete',
                        'imageUrl' => false,
                        'options' => array('class' => 'btn btn-danger btn-sm','title'=>'Delete'),
                    ),
                ),
            ),
        );
    }



    /**
     * Displays a particular model.
     * @param integer $id the ID of the model to be displayed
     */
    public function actionView($id) {
        $this->render('view', array(
            'model' => $this->loadModel($id),
        ));
    }

    /**
     * Creates a new model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     */
    public function actionCreate() {
        $model = new UserMaster;

        // Uncomment the following line if AJAX validation is needed
        // $this->performAjaxValidation($model);

        if (isset($_POST['UserMaster'])) {
            $model->attributes = $_POST['UserMaster'];
            if ($model->save())
                $this->redirect(array('view', 'id' => $model->id));
        }

        $this->render('create', array(
            'model' => $model,
        ));
    }

    /**
     * Updates a particular model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id the ID of the model to be updated
     */
    public function actionUpdate($id) {
        $model = $this->loadModel($id);

        // Uncomment the following line if AJAX validation is needed
        // $this->performAjaxValidation($model);

        if (isset($_POST['UserMaster'])) {
            $model->attributes = $_POST['UserMaster'];
            if ($model->save())
                $this->redirect(array('view', 'id' => $model->id));
        }

        $this->render('update', array(
            'model' => $model,
        ));
    }

    /**
     * Deletes a particular model.
     * If deletion is successful, the browser will be redirected to the 'admin' page.
     * @param integer $id the ID of the model to be deleted
     */
    public function actionDelete($id) {
        $this->loadModel($id)->delete();

        // if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
        if (!isset($_GET['ajax']))
            $this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
    }

    /**
     * Lists all models.
     */
    public function actionIndex() {
        //$model=UserMaster::model()->findAll();
        //print_r($data);exit;
        $model = new UserMaster('search');

        $model->unsetAttributes();

        $columns = $this->columns();
        /**
         * @var $widget EDataTables
         */
        $widget = $this->createWidget('ext.EDataTables.EDataTables', array(
            'id' => 'goldFixing',
            'dataProvider' => $model->search($columns),
            'ajaxUrl' => $this->createUrl($this->getAction()->getId()),
            'columns' => $columns,            
            'htmlOptions' => array('class' => ''),
            'itemsCssClass' => 'table table-striped table-bordered table-condensed items',
            'pagerCssClass' => 'paging_bootstrap pagination',          
            'datatableTemplate' => "<><'row'<'span3'l><'dataTables_toolbar'><'pull-right'f>r>t<'row'<'span3'i><'pull-right'p>>",
            'bootstrap'=>true,
        ));

        if (Yii::app()->getRequest()->getIsAjaxRequest()) {
            echo json_encode($widget->getFormattedData(intval($_GET['sEcho'])));
            Yii::app()->end();
            return;
        }
        $this->render('list', array('widget' => $widget,));
    }

    /**
     * Manages all models.
     */
    public function actionAdmin() {
        $model = new UserMaster('search');
        $model->unsetAttributes();  // clear any default values
        if (isset($_GET['UserMaster']))
            $model->attributes = $_GET['UserMaster'];

        $this->render('admin', array(
            'model' => $model,
        ));
    }

    /**
     * Returns the data model based on the primary key given in the GET variable.
     * If the data model is not found, an HTTP exception will be raised.
     * @param integer $id the ID of the model to be loaded
     * @return UserMaster the loaded model
     * @throws CHttpException
     */
    public function loadModel($id) {
        $model = UserMaster::model()->findByPk($id);
        if ($model === null)
            throw new CHttpException(404, 'The requested page does not exist.');
        return $model;
    }

    /**
     * Performs the AJAX validation.
     * @param UserMaster $model the model to be validated
     */
    protected function performAjaxValidation($model) {
        if (isset($_POST['ajax']) && $_POST['ajax'] === 'user-master-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }
    }

}
