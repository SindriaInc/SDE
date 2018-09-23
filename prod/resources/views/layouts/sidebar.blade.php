@extends('app')

@section('sidebar')

    <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav navbar-sidenav" id="exampleAccordion">

            @if (Auth::guest())
                <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Back to Frontend">
                    <a class="nav-link" href="{{ url('/') }}">
                        <i class="fa fa-fw fa-home"></i>
                        <span class="nav-link-text">Back to Frontend</span>
                    </a>
                </li>
            @endif
            @if(Auth::check())
                @foreach ($sidebar as $side_route => $side)
                    <li class="nav-item{{ Route::currentRouteName() == $side_route ? " active" : "" }}" data-toggle="tooltip" data-placement="right" title="{{ $side['name'] }}">
                        <a class="nav-link" href="{{ route($side_route) }}">
                            <i class="fa fa-fw fa-{{ isset($side['icon']) ? $side['icon'] : 'link' }}"></i>
                            <span class="nav-link-text">{{ $side['name'] }}</span>
                        </a>
                    </li>
                @endforeach
            @endif
        </ul>
        <ul class="navbar-nav sidenav-toggler">
            <li class="nav-item">
                <a class="nav-link text-center" id="sidenavToggler">
                    <i class="fa fa-fw fa-angle-left"></i>
                </a>
            </li>
        </ul>
    </div>
@endsection
